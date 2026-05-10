import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Like } from './entities/like.entity';

@Injectable()
export class SocialService {
  constructor(
    @InjectRepository(Like)
    private readonly likeRepository: Repository<Like>,
  ) {}

  async toggleLike(postId: number, userId: number) {
    const existingLike = await this.likeRepository.findOne({
      where: { postId, userId },
    });

    if (existingLike) {
      await this.likeRepository.delete({ postId, userId });
      return { liked: false };
    } else {
      const newLike = this.likeRepository.create({ postId, userId });
      await this.likeRepository.save(newLike);
      return { liked: true };
    }
  }
}
