import {
  Controller,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  UseGuards,
  Req,
  Get,
} from '@nestjs/common';
import { AuthService } from './auth.service';
import { CreateAuthDto } from './dto/create-auth.dto';
import { UpdateAuthDto } from './dto/update-auth.dto';
import { LocalAuthGuard } from '@/auth/guards/local-auth/local-auth.guard';
import { Request, Response } from 'express';
import { GetUser } from '@/auth/decorators/get-user.decorator';
import { RefreshAuthGuard } from '@/auth/guards/refresh-auth/refresh-auth.guard';
import { Public } from '@/auth/decorators/public.decorator';
import { AuthenticatedUser } from '@workspace/types';

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Public()
  @Post('signup')
  signUp(@Body() createAuthDto: CreateAuthDto) {
    return this.authService.createUser(createAuthDto);
  }

  @Public()
  @UseGuards(LocalAuthGuard)
  @Post('signin')
  async signIn(@Req() req: Request) {
    const user = req.user as AuthenticatedUser;
    return this.authService.signIn(user.id, user.name, user.email, user.role);
  }

  @Public()
  @UseGuards(RefreshAuthGuard)
  @Post('refresh')
  async refreshToken(@Req() req: Request) {
    const user = req.user as AuthenticatedUser;
    return this.authService.refreshToken(
      user.id,
      user.name,
      user.email,
      user.role,
    );
  }

  @Get('me')
  async getMe(@GetUser() user: AuthenticatedUser) {
    return {
      id: user.id,
      name: user.name,
      email: user.email,
      role: user.role,
    };
  }

  @Post('signout')
  async signOut(@GetUser('id') userId: number) {
    await this.authService.signOut(userId);
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
