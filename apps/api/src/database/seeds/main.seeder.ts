import { Auth } from '@/auth/entities/auth.entity';
import { Hashtag } from '@/bookmarks/entities/hashtag.entity';
import { PostHashtag } from '@/bookmarks/entities/post-hashtag.entity';
import { SavedPost } from '@/bookmarks/entities/saved-post.entity';
import { PostMedia } from '@/posts/entities/post-media.entity';
import { Post } from '@/posts/entities/post.entity';
import { Comment } from '@/social/entities/comment.entity';
import { Follow } from '@/social/entities/follow.entity';
import { Like } from '@/social/entities/like.entity';
import { Story } from '@/stories/entities/story.entity';
import { User } from '@/user/entities/user.entity';
import { faker } from '@faker-js/faker';
import { DataSource } from 'typeorm';
import { Seeder, SeederFactoryManager } from 'typeorm-extension';

export class MainSeeder implements Seeder {
  public async run(
    dataSource: DataSource,
    factoryManager: SeederFactoryManager,
  ): Promise<void> {
    const likeRepo = dataSource.getRepository(Like);
    const followRepo = dataSource.getRepository(Follow);
    const postHashtagRepo = dataSource.getRepository(PostHashtag);
    const savesPost = dataSource.getRepository(SavedPost);

    const authFactory = factoryManager.get(Auth);
    const userFactory = factoryManager.get(User);
    const postFactory = factoryManager.get(Post);
    const commentFactory = factoryManager.get(Comment);
    const hashTagFactory = factoryManager.get(Hashtag);
    const postMediaFactory = factoryManager.get(PostMedia);
    const storyFactory = factoryManager.get(Story);

    console.log('Seeding users, auth, story...');
    const users = await userFactory.saveMany(100);
    for (const user of users) {
      await authFactory.save({ user });
      if (faker.datatype.boolean({ probability: 0.3 })) {
        await storyFactory.save({ user });
      }
    }

    console.log('Seeding hashtags...');
    const hashtags = await hashTagFactory.saveMany(20);

    console.log('Seeding posts...');
    const posts = await Promise.all(
      Array(100)
        .fill('')
        .map(async () => {
          const post = await postFactory.make({
            user: faker.helpers.arrayElement(users),
          });
          return post;
        }),
    );
    const savedPosts = await dataSource.getRepository(Post).save(posts);

    //** Add 1-3 images to every single post (Carousels) */
    for (const post of savedPosts) {
      const numMedia = faker.number.int({ min: 1, max: 5 });
      for (let i = 0; i < numMedia; i++) {
        await postMediaFactory.save({
          post,
          sequenceOrder: i + 1,
        });
      }
    }

    console.log('Seeding comments, likes, and follows...');
    for (const post of savedPosts) {
      //** tag */
      const numTags = faker.number.int({ min: 1, max: 3 });
      const randomTags = faker.helpers.arrayElements(hashtags, numTags);
      for (const tag of randomTags) {
        await postHashtagRepo.save({ postId: post.id, hashtagId: tag.id });
      }

      //** comment */
      const numComments = faker.number.int({ min: 0, max: 5 });
      for (let i = 0; i < numComments; i++) {
        await commentFactory.save({
          user: faker.helpers.arrayElement(users),
          post,
        });
      }

      //** like */
      const numLikes = faker.number.int({ min: 2, max: 10 });
      const randomLikers = faker.helpers.arrayElements(users, numLikes);
      for (const liker of randomLikers) {
        await likeRepo.save({ postId: post.id, userId: liker.id });
      }

      //** bookmark */
      const numSaves = faker.number.int({ min: 0, max: 5 });
      const randomSavers = faker.helpers.arrayElements(users, numSaves);
      for (const saver of randomSavers) {
        await savesPost.save({ postId: post.id, userId: saver.id });
      }
    }

    console.log('Seeding follows...');
    for (const user of users) {
      const numFollowers = faker.number.int({ min: 0, max: 5 });
      const otherUsers = users.filter((u) => u.id !== user.id);
      const usersToFollow = faker.helpers.arrayElements(
        otherUsers,
        numFollowers,
      );

      for (const follower of usersToFollow) {
        await followRepo.save({
          followingUser: user,
          followedUser: follower,
        });
      }
    }

    console.log('Seeding done!');
  }
}
