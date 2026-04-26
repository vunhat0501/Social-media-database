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
