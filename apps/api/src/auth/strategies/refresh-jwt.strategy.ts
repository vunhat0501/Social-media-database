import { AuthService } from '@/auth/auth.service';
import refreshConfig from '@/auth/config/refresh.config';
import { AuthJwtPayload } from '@/auth/types/auth-jwt-payload';
import { Inject, Injectable } from '@nestjs/common';
import { ConfigType } from '@nestjs/config';
import { PassportStrategy } from '@nestjs/passport';
import { Request } from 'express';
import { ExtractJwt, Strategy } from 'passport-jwt';

@Injectable()
export class RefreshJwtStrategy extends PassportStrategy(
  Strategy,
  'refresh-jwt',
) {
  constructor(
    @Inject(refreshConfig.KEY)
    private refreshJwtConfiguration: ConfigType<typeof refreshConfig>,
    private readonly authService: AuthService,
  ) {
    super({
      jwtFromRequest: ExtractJwt.fromExtractors([
        (request: Request) => {
          return request?.cookies?.refresh_token || null;
        },
      ]),
      secretOrKey: refreshJwtConfiguration.secret as string,
      ignoreExpiration: false,
      passReqToCallback: true,
    });
  }

  validate(req: Request, payload: AuthJwtPayload) {
    const refreshToken = req.cookies?.refresh_token;
    const userId = payload.sub;
    return this.authService.validateRefreshToken(userId, refreshToken);
  }
}
