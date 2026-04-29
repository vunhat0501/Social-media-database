import { Injectable } from '@nestjs/common';
import { UpdateUserDto } from './dto/update-user.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { User } from '@/user/entities/user.entity';
import { Auth } from '@/auth/entities/auth.entity';

@Injectable()
export class UserService {
  constructor(
    @InjectRepository(User)
    private userRepository: Repository<User>,
    @InjectRepository(Auth)
    private authRepository: Repository<Auth>,
  ) {}

  async findByEmail(email: string): Promise<User | null> {
    return await this.userRepository.findOne({
      where: { email },
      withDeleted: true,
    });
  }

  findAll() {
    return `This action returns all users`;
  }

  async findOne(userId: number) {
    return await this.userRepository.findOneBy({ id: userId });
  }

  update(id: number, updateUserDto: UpdateUserDto) {
    return `This action updates a #${id} user`;
  }

  async softDeleteUser(id: number): Promise<void> {
    const result = await this.userRepository.softDelete(id);
    if (result.affected === 0) {
      throw new Error(`User with ID ${id} not found`);
    }

    await this.authRepository.update({ user: { id } }, { refreshToken: null });
  }
}
