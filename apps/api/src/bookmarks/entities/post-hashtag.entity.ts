import { Hashtag } from '@/bookmarks/entities/hashtag.entity';
import { Post } from '@/posts/entities/post.entity';
import { Entity, Index, JoinColumn, ManyToOne, PrimaryColumn } from 'typeorm';

@Entity('post_hashtags')
export class PostHashtag {
  @PrimaryColumn({ name: 'post_id' })
  postId: number;

  @Index()
  @PrimaryColumn({ name: 'hashtag_id' })
  hashtagId: number;

  @ManyToOne(() => Post, (post) => post.hashtags, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'post_id' })
  post: Post;

  @ManyToOne(() => Hashtag, (hashtag) => hashtag.posts, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'hashtag_id' })
  hashtag: Hashtag;
}
