import { Module } from '@nestjs/common';
import { BookmarksService } from './bookmarks.service';
import { BookmarksController } from './bookmarks.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { SavedPost } from '@/bookmarks/entities/saved-post.entity';
import { Hashtag } from '@/bookmarks/entities/hashtag.entity';
import { PostHashtag } from '@/bookmarks/entities/post-hashtag.entity';

@Module({
  imports: [TypeOrmModule.forFeature([SavedPost, Hashtag, PostHashtag])],
  controllers: [BookmarksController],
  providers: [BookmarksService],
})
export class BookmarksModule {}
