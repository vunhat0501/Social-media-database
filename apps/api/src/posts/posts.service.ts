import { Injectable } from '@nestjs/common';
import { CreatePostDto } from './dto/create-post.dto';
import { UpdatePostDto } from './dto/update-post.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Post } from './entities/post.entity';

@Injectable()
export class PostsService {
  constructor(
    @InjectRepository(Post)
    private postsRepository: Repository<Post>,
  ) {}

  create(createPostDto: CreatePostDto) {
    return 'This action adds a new post';
  }

  findAll() {
    return this.postsRepository.find({
      relations: ['user', 'user.followers', 'media', 'comments', 'comments.user', 'likes', 'hashtags', 'hashtags.hashtag'],
      order: {
        createdAt: 'DESC',
      },
    });
  }

  findFollowingPosts(userId: number) {
    return this.postsRepository.find({
      where: {
        user: {
          followers: {
            followingUserId: userId,
          },
        },
      },
      relations: ['user', 'user.followers', 'media', 'comments', 'comments.user', 'likes', 'hashtags', 'hashtags.hashtag'],
      order: {
        createdAt: 'DESC',
      },
    });
  }

  findOne(id: number) {
    return this.postsRepository.findOne({
      where: { id },
      relations: ['user', 'user.followers', 'media', 'comments', 'comments.user', 'likes', 'hashtags', 'hashtags.hashtag'],
      order: {
        media: {
          sequenceOrder: 'ASC',
        },
        comments: {
          createdAt: 'ASC',
        },
      },
    });
  }

  update(id: number, updatePostDto: UpdatePostDto) {
    return `This action updates a #${id} post`;
  }

  remove(id: number) {
    return `This action removes a #${id} post`;
  }
}
