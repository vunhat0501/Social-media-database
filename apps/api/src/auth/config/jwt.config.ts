import { env } from '@/config/env.config';
import { registerAs } from '@nestjs/config';
import { JwtModuleOptions } from '@nestjs/jwt';

export default registerAs(
  'jwt',
  (): JwtModuleOptions => ({
    secret: env.JWT_SECRET,
    signOptions: {
      expiresIn: env.JWT_EXPIRES_IN,
    },
  }),
);
