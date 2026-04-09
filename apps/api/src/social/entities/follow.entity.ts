import { User } from '@/user/entities/user.entity';
import {
  CreateDateColumn,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  PrimaryColumn,
} from 'typeorm';

@Entity('follows')
export class Follow {
  @PrimaryColumn({ name: 'following_user_id' })
  followingUserId: number;

  @Index()
  @PrimaryColumn({ name: 'followed_user_id' })
  followedUserId: number;

  @CreateDateColumn({ name: 'created_at' })
  createdAt: Date;

  @ManyToOne(() => User, (user) => user.following, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'following_user_id' })
  followingUser: User;

  @ManyToOne(() => User, (user) => user.followers, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'followed_user_id' })
  followedUser: User;
}
