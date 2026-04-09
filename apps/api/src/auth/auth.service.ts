import { ConflictException, Injectable } from '@nestjs/common';
import { CreateAuthDto } from './dto/create-auth.dto';
import { UpdateAuthDto } from './dto/update-auth.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { Auth } from '@/auth/entities/auth.entity';
import { Repository } from 'typeorm';
import { UserService } from '@/user/user.service';

@Injectable()
export class AuthService {
  constructor(
    private readonly userService: UserService,
    @InjectRepository(Auth)
    private authRepository: Repository<Auth>,
  ) {}

  async createUser(createAuthDto: CreateAuthDto) {
    const user = await this.userService.findByEmail(createAuthDto.email);
    if (user) {
      throw new ConflictException('User already exists');
    }

    const savedUser = await this.userService.create(createAuthDto);

    const newAuth = this.authRepository.create({
      ...createAuthDto,
      user: savedUser,
    });

    return this.authRepository.save(newAuth);
  }

  async validateLocalUser(email: string, password: string) {
    //** Find user by mail
    // * Check if user exist and password is correct
    // * if password is not correct throw unauthorized exception
    // * else return return user id, name, role */
  }

  async login(userId: string, name: string) {
    //** Call generate access/refresh token func
    // * hash the refresh token
    // * update hashed refresh token in db
    // * return user id, name, access/refresh token */
  }

  update(id: number, updateAuthDto: UpdateAuthDto) {
    return `This action updates a #${id} auth`;
  }

  remove(id: number) {
    return `This action removes a #${id} auth`;
  }
}
