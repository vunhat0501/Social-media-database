import { Module } from '@nestjs/common';
import { PostsService } from './posts.service';
import { PostsController } from './posts.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Post } from '@/posts/entities/post.entity';
import { PostMedia } from '@/posts/entities/post-media.entity';
import { Hashtag } from '@/bookmarks/entities/hashtag.entity';
import { PostHashtag } from '@/bookmarks/entities/post-hashtag.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Post, PostMedia, Hashtag, PostHashtag])],
  controllers: [PostsController],
  providers: [PostsService],
})
export class PostsModule {}
