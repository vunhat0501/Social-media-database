import { Controller, Post, Param, ParseIntPipe, UseGuards } from '@nestjs/common';
import { SocialService } from './social.service';
import { JwtAuthGuard } from '@/auth/guards/jwt-auth/jwt-auth.guard';
import { GetUser } from '@/auth/decorators/get-user.decorator';

@Controller('social')
export class SocialController {
  constructor(private readonly socialService: SocialService) {}

  @UseGuards(JwtAuthGuard)
  @Post('like/:postId')
  toggleLike(
    @Param('postId', ParseIntPipe) postId: number,
    @GetUser('id') userId: number,
  ) {
    return this.socialService.toggleLike(postId, userId);
  }

  @UseGuards(JwtAuthGuard)
  @Post('follow/:userId')
  toggleFollow(
    @Param('userId', ParseIntPipe) followedUserId: number,
    @GetUser('id') followingUserId: number,
  ) {
    return this.socialService.toggleFollow(followedUserId, followingUserId);
  }
}
