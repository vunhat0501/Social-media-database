import { Injectable, BadRequestException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Like } from './entities/like.entity';
import { Follow } from './entities/follow.entity';

@Injectable()
export class SocialService {
  constructor(
    @InjectRepository(Like)
    private readonly likeRepository: Repository<Like>,
    @InjectRepository(Follow)
    private readonly followRepository: Repository<Follow>,
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

  async toggleFollow(followedUserId: number, followingUserId: number) {
    if (followedUserId === followingUserId) {
      throw new BadRequestException("You cannot follow yourself");
    }

    const existingFollow = await this.followRepository.findOne({
      where: { followedUserId, followingUserId },
    });

    if (existingFollow) {
      await this.followRepository.delete({ followedUserId, followingUserId });
      return { following: false };
    } else {
      const newFollow = this.followRepository.create({ followedUserId, followingUserId });
      await this.followRepository.save(newFollow);
      return { following: true };
    }
  }
}
