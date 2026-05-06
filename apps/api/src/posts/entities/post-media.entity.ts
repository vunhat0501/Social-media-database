import { Post } from '@/posts/entities/post.entity';
import {
  Column,
  CreateDateColumn,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from 'typeorm';

@Entity('post_media')
@Index('idx_post_media_sequence', ['post', 'sequenceOrder'])
export class PostMedia {
  @PrimaryGeneratedColumn('increment')
  id: number;

  @Column({ name: 'media_url' })
  mediaUrl: string;

  @Column({ name: 'media_type', default: 'image' })
  mediaType: string;

  @Column({ name: 'sequence_order', default: 1 })
  sequenceOrder: number;

  @CreateDateColumn({ name: 'created_at' })
  createdAt: Date;

  @ManyToOne(() => Post, (post) => post.media, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'post_id' })
  post: Post;
}
