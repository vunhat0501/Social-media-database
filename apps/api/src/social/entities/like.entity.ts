import { Post } from '@/posts/entities/post.entity';
import { User } from '@/user/entities/user.entity';
import {
  CreateDateColumn,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  PrimaryColumn,
} from 'typeorm';

@Entity('likes')
export class Like {
  @PrimaryColumn({ name: 'user_id' })
  userId: number;

  @Index()
  @PrimaryColumn({ name: 'post_id' })
  postId: number;

  @CreateDateColumn({ name: 'created_at' })
  createdAt: Date;

  @ManyToOne(() => User, (user) => user.likes, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'user_id' })
  user: User;

  @ManyToOne(() => Post, (post) => post.likes, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'post_id' })
  post: Post;
}
