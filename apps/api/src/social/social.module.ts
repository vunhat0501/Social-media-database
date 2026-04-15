import { Module } from '@nestjs/common';
import { SocialService } from './social.service';
import { SocialController } from './social.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Comment } from '@/social/entities/comment.entity';
import { Like } from '@/social/entities/like.entity';
import { Follow } from '@/social/entities/follow.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Comment, Like, Follow])],
  controllers: [SocialController],
  providers: [SocialService],
})
export class SocialModule {}
