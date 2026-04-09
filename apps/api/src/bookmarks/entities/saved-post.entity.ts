import { Post } from '@/posts/entities/post.entity';
import { User } from '@/user/entities/user.entity';
import {
  CreateDateColumn,
  Entity,
  JoinColumn,
  ManyToOne,
  PrimaryColumn,
} from 'typeorm';

@Entity('saved_posts')
export class SavedPost {
  @PrimaryColumn({ name: 'user_id' })
  userId: number;

  @PrimaryColumn({ name: 'post_id' })
  postId: number;

  @CreateDateColumn({ name: 'created_at' })
  createdAt: Date;

  @ManyToOne(() => User, (user) => user.savedPosts, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'user_id' })
  user: User;

  @ManyToOne(() => Post, (post) => post.savedBy, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'post_id' })
  post: Post;
}
