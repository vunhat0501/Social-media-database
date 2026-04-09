import { User } from '@/user/entities/user.entity';
import {
  Column,
  CreateDateColumn,
  Entity,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
  Unique,
} from 'typeorm';

@Entity('auth')
@Unique(['user', 'authProvider'])
@Unique(['authProvider', 'authProviderId'])
export class Auth {
  @PrimaryGeneratedColumn('increment')
  id: number;

  @Column({ name: 'hashed_password', nullable: true })
  hashedPassword: string;

  @Column({ name: 'auth_provider', default: 'local' })
  authProvider: string;

  @Column({ name: 'auth_provider_id', nullable: true })
  authProviderId: string;

  @Column({ name: 'email_verified', default: false })
  emailVerified: boolean;

  @Column({ name: 'refresh_token', nullable: true })
  refreshToken: string;

  @CreateDateColumn({ name: 'created_at' })
  createdAt: Date;

  @ManyToOne(() => User, (user) => user.auths, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'user_id' })
  user: User;
}
