import {
  ConflictException,
  Inject,
  Injectable,
  NotFoundException,
  UnauthorizedException,
} from '@nestjs/common';
import { CreateAuthDto } from './dto/create-auth.dto';
import { UpdateAuthDto } from './dto/update-auth.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { Auth } from '@/auth/entities/auth.entity';
import { DataSource, Repository } from 'typeorm';
import { UserService } from '@/user/user.service';
import { hash, verify } from 'argon2';
import { User } from '@/user/entities/user.entity';
import { AuthJwtPayload } from '@/auth/types/auth-jwt-payload';
import { JwtService } from '@nestjs/jwt';
import { ConfigType } from '@nestjs/config';
import refreshConfig from '@/auth/config/refresh.config';

@Injectable()
export class AuthService {
  constructor(
    @InjectRepository(Auth)
    private authRepository: Repository<Auth>,
    private readonly userService: UserService,
    private readonly dataSource: DataSource,
    private readonly jwtService: JwtService,
    @Inject(refreshConfig.KEY)
    private readonly refreshTokenConfig: ConfigType<typeof refreshConfig>,
  ) {}

  async createUser(createAuthDto: CreateAuthDto) {
    const user = await this.userService.findByEmail(createAuthDto.email);
    if (user) {
      throw new ConflictException('User already exists');
    }

    const hashedPassword = await hash(createAuthDto.password);

    return this.dataSource.transaction(async (transactionalEntityManager) => {
      const newUser = transactionalEntityManager.create(User, {
        userName: createAuthDto.userName,
        email: createAuthDto.email,
      });
      const savedUser = await transactionalEntityManager.save(newUser);
      const newAuth = transactionalEntityManager.create(Auth, {
        hashedPassword,
        authProvider: 'local',
        user: savedUser,
      });

      return transactionalEntityManager.save(newAuth);
    });
  }

  async validateLocalUser(email: string, password: string) {
    const authRecord = await this.authRepository.findOne({
      where: {
        authProvider: 'local',
        user: {
          email,
        },
      },
      relations: ['user'],
    });

    if (!authRecord || !authRecord.hashedPassword) {
      throw new UnauthorizedException('Invalid email or password');
    }
    const isPasswordMatched = await verify(authRecord.hashedPassword, password);
    if (!isPasswordMatched) {
      throw new UnauthorizedException('Invalid credentials');
    }
    // * else return return user id, name, role */
    const { user } = authRecord;
    return {
      id: user.id,
      name: user.userName,
    };
  }

  async login(userId: number, name: string) {
    const { accessToken, refreshToken } = await this.generateTokens(userId);
    const hashedRefreshToken = await hash(refreshToken);
    const result = await this.authRepository.update(
      {
        authProvider: 'local',
        user: userId as any,
      },
      {
        refreshToken: hashedRefreshToken,
      },
    );

    if (result.affected === 0) {
      throw new NotFoundException('User not found');
    }

    return {
      id: userId,
      name,
      accessToken,
      refreshToken,
    };
  }

  async logout(userId: number) {
    return this.authRepository.update(
      { user: userId as any, authProvider: 'local' },
      { refreshToken: null },
    );
  }

  async generateTokens(userId: number) {
    const payload: AuthJwtPayload = { sub: userId };
    const [accessToken, refreshToken] = await Promise.all([
      this.jwtService.signAsync(payload),
      this.jwtService.signAsync(payload, this.refreshTokenConfig),
    ]);

    return {
      accessToken,
      refreshToken,
    };
  }

  async refreshToken(userId: number, name: string) {
    const { accessToken, refreshToken } = await this.generateTokens(userId);
    const hashedRefreshToken = await hash(refreshToken);
    const result = await this.authRepository.update(
      {
        authProvider: 'local',
        user: userId as any,
      },
      {
        refreshToken: hashedRefreshToken,
      },
    );

    if (result.affected === 0) {
      throw new NotFoundException('User not found');
    }
    return {
      id: userId,
      name,
      accessToken,
      refreshToken,
    };
  }

  async validateJwtUser(userId: number) {
    const user = await this.userService.findOne(userId);
    if (!user) {
      throw new UnauthorizedException('User not found');
    }
    const currentUser = {
      id: user.id,
      name: user.userName,
      email: user.email,
    };

    return currentUser;
  }

  async validateRefreshToken(userId: number, refreshToken: string) {
    const authRecord = await this.authRepository.findOne({
      where: {
        authProvider: 'local',
        user: {
          id: userId,
        },
      },
      relations: ['user'],
    });
    if (!authRecord || !authRecord.refreshToken) {
      throw new UnauthorizedException('Invalid refresh token');
    }

    const isRefreshTokenMatched = await verify(
      authRecord.refreshToken,
      refreshToken,
    );

    if (!isRefreshTokenMatched) {
      throw new UnauthorizedException('Invalid refresh token');
    }
    const { user } = authRecord;
    return {
      id: user.id,
      name: user.userName,
      email: user.email,
    };
  }

  update(id: number, updateAuthDto: UpdateAuthDto) {
    return `This action updates a #${id} auth`;
  }

  remove(id: number) {
    return `This action removes a #${id} auth`;
  }
}
