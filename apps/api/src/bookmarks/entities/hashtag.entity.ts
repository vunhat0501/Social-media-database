import { PostHashtag } from '@/bookmarks/entities/post-hashtag.entity';
import {
  Column,
  CreateDateColumn,
  Entity,
  Index,
  OneToMany,
  PrimaryGeneratedColumn,
} from 'typeorm';

@Entity('hashtags')
export class Hashtag {
  @PrimaryGeneratedColumn('increment')
  id: number;

  @Index()
  @Column({ unique: true })
  name: string;

  @CreateDateColumn({ name: 'created_at' })
  createdAt: Date;

  @OneToMany(() => PostHashtag, (postHashtag) => postHashtag.hashtag)
  posts: PostHashtag[];
}
