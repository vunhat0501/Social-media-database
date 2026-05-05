import { Injectable, NotFoundException } from '@nestjs/common';
import { CreatePostDto } from './dto/create-post.dto';
import { UpdatePostDto } from './dto/update-post.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, DataSource } from 'typeorm';
import { Post } from './entities/post.entity';
import { PostMedia } from './entities/post-media.entity';
import { Hashtag } from '@/bookmarks/entities/hashtag.entity';
import { PostHashtag } from '@/bookmarks/entities/post-hashtag.entity';

@Injectable()
export class PostsService {
  constructor(
    @InjectRepository(Post)
    private postsRepository: Repository<Post>,
    @InjectRepository(PostMedia)
    private postMediaRepository: Repository<PostMedia>,
    @InjectRepository(Hashtag)
    private hashtagRepository: Repository<Hashtag>,
    @InjectRepository(PostHashtag)
    private postHashtagRepository: Repository<PostHashtag>,
    private dataSource: DataSource,
  ) {}

  async create(userId: number, createPostDto: CreatePostDto) {
    const { media, hashtags, ...postData } = createPostDto;

    const queryRunner = this.dataSource.createQueryRunner();
    await queryRunner.connect();
    await queryRunner.startTransaction();

    try {
      // 1. Create Post
      const post = this.postsRepository.create({
        ...postData,
        user: { id: userId },
      });
      const savedPost = await queryRunner.manager.save(Post, post);

      // 2. Save Media
      if (media && media.length > 0) {
        const mediaEntities = media.map((m, index) =>
          this.postMediaRepository.create({
            ...m,
            sequenceOrder: m.sequenceOrder ?? index + 1,
            post: savedPost,
          }),
        );
        await queryRunner.manager.save(PostMedia, mediaEntities);
      }

      // 3. Extract and save Hashtags
      const extractedHashtags = new Set(hashtags || []);
      if (postData.title) {
        const titleHashtags = postData.title.match(/#[\w]+/g);
        if (titleHashtags) {
          titleHashtags.forEach((tag) => extractedHashtags.add(tag.substring(1).toLowerCase()));
        }
      }

      if (extractedHashtags.size > 0) {
        for (const tagName of extractedHashtags) {
          let hashtag = await queryRunner.manager.findOne(Hashtag, {
            where: { name: tagName },
          });

          if (!hashtag) {
            hashtag = this.hashtagRepository.create({ name: tagName });
            hashtag = await queryRunner.manager.save(Hashtag, hashtag);
          }

          const postHashtag = this.postHashtagRepository.create({
            postId: savedPost.id,
            hashtagId: hashtag.id,
            post: savedPost,
            hashtag: hashtag,
          });
          await queryRunner.manager.save(PostHashtag, postHashtag);
        }
      }

      await queryRunner.commitTransaction();

      return this.findOne(savedPost.id);
    } catch (err) {
      await queryRunner.rollbackTransaction();
      throw err;
    } finally {
      await queryRunner.release();
    }
  }

  findAll() {
    return this.postsRepository.find({
      relations: ['user', 'media', 'comments', 'comments.user', 'likes', 'hashtags', 'hashtags.hashtag'],
      order: {
        createdAt: 'DESC',
      },
    });
  }

  async findOne(id: number) {
    const post = await this.postsRepository.findOne({
      where: { id },
      relations: ['user', 'media', 'comments', 'comments.user', 'likes', 'hashtags', 'hashtags.hashtag'],
      order: {
        media: {
          sequenceOrder: 'ASC',
        },
        comments: {
          createdAt: 'ASC',
        },
      },
    });

    if (!post) {
      throw new NotFoundException(`Post #${id} not found`);
    }
    return post;
  }

  async update(id: number, userId: number, updatePostDto: UpdatePostDto) {
    const post = await this.postsRepository.findOne({ where: { id, user: { id: userId } } });
    if (!post) {
      throw new NotFoundException(`Post #${id} not found or you don't have permission to edit it.`);
    }

    const { media, hashtags, ...postData } = updatePostDto;

    const queryRunner = this.dataSource.createQueryRunner();
    await queryRunner.connect();
    await queryRunner.startTransaction();

    try {
      if (Object.keys(postData).length > 0) {
        await queryRunner.manager.update(Post, id, postData);
      }

      if (media) {
        await queryRunner.manager.delete(PostMedia, { post: { id } });
        if (media.length > 0) {
          const mediaEntities = media.map((m, index) =>
            this.postMediaRepository.create({
              ...m,
              sequenceOrder: m.sequenceOrder ?? index + 1,
              post: { id },
            }),
          );
          await queryRunner.manager.save(PostMedia, mediaEntities);
        }
      }

      if (hashtags || updatePostDto.title) {
        await queryRunner.manager.delete(PostHashtag, { post: { id } });
        const extractedHashtags = new Set(hashtags || []);
        const titleContent = updatePostDto.title ?? post.title;
        if (titleContent) {
           const titleHashtags = titleContent.match(/#[\w]+/g);
           if (titleHashtags) {
             titleHashtags.forEach((tag) => extractedHashtags.add(tag.substring(1).toLowerCase()));
           }
        }

        for (const tagName of extractedHashtags) {
          let hashtag = await queryRunner.manager.findOne(Hashtag, {
            where: { name: tagName },
          });

          if (!hashtag) {
            hashtag = this.hashtagRepository.create({ name: tagName });
            hashtag = await queryRunner.manager.save(Hashtag, hashtag);
          }

          const postHashtag = this.postHashtagRepository.create({
            postId: id,
            hashtagId: hashtag.id,
            post: { id },
            hashtag: hashtag,
          });
          await queryRunner.manager.save(PostHashtag, postHashtag);
        }
      }

      await queryRunner.commitTransaction();

      return this.findOne(id);
    } catch (err) {
      await queryRunner.rollbackTransaction();
      throw err;
    } finally {
      await queryRunner.release();
    }
  }

  async remove(id: number, userId: number) {
    const post = await this.postsRepository.findOne({ where: { id, user: { id: userId } } });
    if (!post) {
      throw new NotFoundException(`Post #${id} not found or you don't have permission to delete it.`);
    }
    
    await this.postsRepository.remove(post);
    return { success: true, message: `Post #${id} removed successfully.` };
  }
}
