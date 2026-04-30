export enum Role {
  ADMIN = 'admin',
  USER = 'user',
}

export interface AuthenticatedUser {
  id: number;
  name: string;
  email: string;
  role: Role;
}

export interface ProfileData {
  id: number;
  userName: string;
  email: string;
  role: Role;
  avatarUrl: string;
  bio: string;
  createdAt: Date;
}
