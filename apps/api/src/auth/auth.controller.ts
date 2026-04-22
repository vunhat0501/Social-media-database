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
  UseInterceptors,
} from '@nestjs/common';
import { AuthService } from './auth.service';
import { CreateAuthDto } from './dto/create-auth.dto';
import { UpdateAuthDto } from './dto/update-auth.dto';
import { LocalAuthGuard } from '@/auth/guards/local-auth/local-auth.guard';
import { Request, Response } from 'express';
import { JwtAuthGuard } from '@/auth/guards/jwt-auth/jwt-auth.guard';
import { GetUser } from '@/auth/decorators/get-user.decorator';
import { RefreshAuthGuard } from '@/auth/guards/refresh-auth/refresh-auth.guard';
import { TokenInterceptor } from './interceptor/token.interceptor';

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
  @UseInterceptors(TokenInterceptor)
  @Post('signin')
  async login(@Req() req: Request) {
    const user = req.user as { id: number; name: string };
    return this.authService.login(user.id, user.name);
  }

  @UseGuards(RefreshAuthGuard)
  @UseInterceptors(TokenInterceptor)
  @Post('refresh')
  async refreshToken(@Req() req: Request) {
    const user = req.user as { id: number; name: string };
    return this.authService.refreshToken(user.id, user.name);
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
    res.clearCookie('refresh_token', { path: '/' });
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
