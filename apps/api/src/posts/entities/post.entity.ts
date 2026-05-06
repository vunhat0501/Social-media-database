import { PostHashtag } from '@/bookmarks/entities/post-hashtag.entity';
import { SavedPost } from '@/bookmarks/entities/saved-post.entity';
import { PostMedia } from '@/posts/entities/post-media.entity';
import { Comment } from '@/social/entities/comment.entity';
import { Like } from '@/social/entities/like.entity';
import { User } from '@/user/entities/user.entity';
import {
  Column,
  CreateDateColumn,
  DeleteDateColumn,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';

@Index('idx_user_post_timeline', ['user', 'createdAt'], {
  where: 'deleted_at IS NULL',
})
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

  @UpdateDateColumn({ name: 'updated_at' })
  updatedAt: Date;

  @DeleteDateColumn({ name: 'deleted_at', nullable: true })
  deletedAt: Date;

  @Index()
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
