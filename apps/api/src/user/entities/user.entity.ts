import { Auth } from '@/auth/entities/auth.entity';
import { SavedPost } from '@/bookmarks/entities/saved-post.entity';
import { Post } from '@/posts/entities/post.entity';
import { Comment } from '@/social/entities/comment.entity';
import { Follow } from '@/social/entities/follow.entity';
import { Like } from '@/social/entities/like.entity';
import { Story } from '@/stories/entities/story.entity';
import { Role } from '@workspace/types';
import {
  Column,
  CreateDateColumn,
  Entity,
  Index,
  OneToMany,
  PrimaryGeneratedColumn,
} from 'typeorm';

@Entity('users')
export class User {
  @PrimaryGeneratedColumn('increment')
  id: number;

  @Index()
  @Column({ name: 'user_name', unique: true })
  userName: string;

  @Column({ unique: true })
  email: string;

  @Column({ type: 'enum', enum: Role, default: Role.USER })
  role: Role;

  @Column({ name: 'avatar_url', nullable: true })
  avatarUrl: string;

  @Column({ nullable: true })
  bio: string;

  @CreateDateColumn({ name: 'created_at' })
  createdAt: Date;

  @OneToMany(() => Auth, (auth) => auth.user)
  auths: Auth[];

  @OneToMany(() => Post, (post) => post.user)
  posts: Post[];

  @OneToMany(() => Story, (story) => story.user)
  stories: Story[];

  @OneToMany(() => Follow, (follow) => follow.followingUser)
  following: Follow[];

  @OneToMany(() => Follow, (follow) => follow.followedUser)
  followers: Follow[];

  @OneToMany(() => Comment, (comment) => comment.user)
  comments: Comment[];

  @OneToMany(() => Like, (like) => like.user)
  likes: Like[];

  @OneToMany(() => SavedPost, (savedPost) => savedPost.user)
  savedPosts: SavedPost[];
}
