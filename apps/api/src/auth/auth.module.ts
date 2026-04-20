import { Module } from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthController } from './auth.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Auth } from '@/auth/entities/auth.entity';
import { UserModule } from '@/user/user.module';
import { LocalStrategy } from '@/auth/strategies/local.strategy';
import { JwtModule } from '@nestjs/jwt';
import jwtConfig from '@/auth/config/jwt.config';
import { ConfigModule } from '@nestjs/config';
import { JwtStrategy } from '@/auth/strategies/jwt.strategy';
import refreshConfig from '@/auth/config/refresh.config';
import { RefreshJwtStrategy } from '@/auth/strategies/refresh-jwt.strategy';

@Module({
  imports: [
    TypeOrmModule.forFeature([Auth]),
    JwtModule.registerAsync(jwtConfig.asProvider()),
    ConfigModule.forFeature(jwtConfig),
    ConfigModule.forFeature(refreshConfig),
    UserModule,
  ],
  controllers: [AuthController],
  providers: [AuthService, LocalStrategy, JwtStrategy, RefreshJwtStrategy],
})
export class AuthModule {}
