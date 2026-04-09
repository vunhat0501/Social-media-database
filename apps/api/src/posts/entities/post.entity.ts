import { PostHashtag } from '@/bookmarks/entities/post-hashtag.entity';
import { SavedPost } from '@/bookmarks/entities/saved-post.entity';
import { PostMedia } from '@/posts/entities/post-media.entity';
import { Comment } from '@/social/entities/comment.entity';
import { Like } from '@/social/entities/like.entity';
import { User } from '@/user/entities/user.entity';
import {
  Column,
  CreateDateColumn,
  Entity,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
} from 'typeorm';

@Entity('posts')
export class Post {
  @PrimaryGeneratedColumn('increment')
  id: number;

  @Column({ type: 'text', nullable: true })
  title: string;

  @Column({ default: 'public' })
  status: string;

  @Column({ type: 'text', nullable: true })
  location: string;

  @CreateDateColumn({ name: 'created_at' })
  createdAt: Date;

  @ManyToOne(() => User, (user) => user.posts, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'user_id' })
  user: User;

  @OneToMany(() => PostMedia, (media) => media.post)
  media: PostMedia[];

  @OneToMany(() => Comment, (comment) => comment.post)
  comments: Comment[];

  @OneToMany(() => Like, (like) => like.post)
  likes: Like[];

  @OneToMany(() => SavedPost, (savedPost) => savedPost.post)
  savedBy: SavedPost[];

  @OneToMany(() => PostHashtag, (postHashtag) => postHashtag.post)
  hashtags: PostHashtag[];
}
