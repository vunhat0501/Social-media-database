import { env } from '@/config/env.config';
import { registerAs } from '@nestjs/config';
import { JwtSignOptions } from '@nestjs/jwt';

export default registerAs(
  'refresh-jwt',
  (): JwtSignOptions => ({
    secret: env.REFRESH_JWT_SECRET,
    expiresIn: env.REFRESH_JWT_EXPIRES_IN,
  }),
);
