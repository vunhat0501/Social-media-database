import {
  Controller,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  UseGuards,
  Req,
  Res,
  Get,
} from '@nestjs/common';
import { AuthService } from './auth.service';
import { CreateAuthDto } from './dto/create-auth.dto';
import { UpdateAuthDto } from './dto/update-auth.dto';
import { LocalAuthGuard } from '@/auth/guards/local-auth/local-auth.guard';
import { Request, Response } from 'express';
import { env } from '@/config/env.config';
import { JwtAuthGuard } from '@/auth/guards/jwt-auth/jwt-auth.guard';
import { GetUser } from '@/auth/decorators/get-user.decorator';
import { RefreshAuthGuard } from '@/auth/guards/refresh-auth/refresh-auth.guard';

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  // *TODO: create auth guard, strategies, hash user password, create and add access/refresh token to cookie
  // *TODO: create public, getUser and role decorator */

  @Post('signup')
  register(@Body() createAuthDto: CreateAuthDto) {
    return this.authService.createUser(createAuthDto);
  }

  @UseGuards(LocalAuthGuard)
  @Post('signin')
  async login(@Req() req: Request, @Res({ passthrough: true }) res: Response) {
    const user = req.user as { id: number; name: string };
    const { accessToken, refreshToken, id, name } =
      await this.authService.login(user.id, user.name);
    res.cookie('access_token', accessToken, {
      httpOnly: true,
      secure: env.NODE_ENV === 'production',
      sameSite: 'lax',
      maxAge: 1000 * 60 * 15, // 15 mins
    });
    res.cookie('refresh_token', refreshToken, {
      httpOnly: true,
      secure: env.NODE_ENV === 'production',
      sameSite: 'lax',
      maxAge: 1000 * 60 * 60 * 24 * 30, // 30 days
    });
    return { id, name };
  }

  @UseGuards(RefreshAuthGuard)
  @Post('refresh')
  async refreshToken(
    @Req() req: Request,
    @Res({ passthrough: true }) res: Response,
  ) {
    const user = req.user as { id: number; name: string };
    const { accessToken, refreshToken } = await this.authService.refreshToken(
      user.id,
      user.name,
    );

    res.cookie('access_token', accessToken, {
      httpOnly: true,
      secure: env.NODE_ENV === 'production',
      sameSite: 'lax',
      maxAge: 1000 * 60 * 15, // 15 minutes
    });

    res.cookie('refresh_token', refreshToken, {
      httpOnly: true,
      secure: env.NODE_ENV === 'production',
      sameSite: 'lax',
      maxAge: 1000 * 60 * 60 * 24 * 30, // 30 days
    });

    return { success: true };
  }

  @UseGuards(JwtAuthGuard)
  @Get('me')
  async getMe(@GetUser() user: any) {
    return {
      id: user.id,
      name: user.name,
      email: user.email,
    };
  }

  @UseGuards(JwtAuthGuard)
  @Post('signout')
  async logout(
    @GetUser('id') userId: number,
    @Res({ passthrough: true }) res: Response,
  ) {
    await this.authService.logout(userId);
    res.clearCookie('access_token', { path: '/' });
    res.clearCookie('refresh_token', { path: '/auth/refresh' });
    return { success: true };
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateAuthDto: UpdateAuthDto) {
    return this.authService.update(+id, updateAuthDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.authService.remove(+id);
  }
}
