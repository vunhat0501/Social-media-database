import { Role } from '@/user/entities/user.entity';

export type AuthJwtPayload = {
  sub: number;
  name: string;
  email: string;
  role: Role;
};
