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
  private dataSource: DataSource;
  private factoryManager: SeederFactoryManager;
  private users: User[] = [];
  private hashtags: Hashtag[] = [];
  private savedPosts: Post[] = [];

  public async run(
    dataSource: DataSource,
    factoryManager: SeederFactoryManager,
  ): Promise<void> {
    this.dataSource = dataSource;
    this.factoryManager = factoryManager;

    console.log('Start seeding...');

    await this.seedUsersAuthStories();
    await this.seedHashTags();
    await this.seedPostsAndMedia();
    await this.seedInteractions();
    await this.seedFollows();

    console.log('Finished seeding!');
  }

  private async seedUsersAuthStories() {
    console.log('Seeding users, auth, stories...');

    const userFactory = this.factoryManager.get(User);
    const authFactory = this.factoryManager.get(Auth);
    const storyFactory = this.factoryManager.get(Story);

    this.users = await userFactory.saveMany(100);
    for (const user of this.users) {
      await authFactory.save({ user });
      if (faker.datatype.boolean({ probability: 0.3 })) {
        await storyFactory.save({ user });
      }
    }
  }

  private async seedHashTags() {
    console.log('Seeding hashtags...');

    const hashTagFactory = this.factoryManager.get(Hashtag);
    this.hashtags = await hashTagFactory.saveMany(20);
  }

  private async seedPostsAndMedia() {
    console.log('Seeding posts, media...');

    const postFactory = this.factoryManager.get(Post);
    const postMediaFactory = this.factoryManager.get(PostMedia);
    const postRepo = this.dataSource.getRepository(Post);

    const posts = await Promise.all(
      Array(100)
        .fill('')
        .map(() =>
          postFactory.make({ user: faker.helpers.arrayElement(this.users) }),
        ),
    );
    this.savedPosts = await postRepo.save(posts);

    //** Add 1-3 images to every single post (Carousels) */
    for (const post of this.savedPosts) {
      const numMedia = faker.number.int({ min: 1, max: 5 });
      for (let i = 0; i < numMedia; i++) {
        await postMediaFactory.save({
          post,
          sequenceOrder: i + 1,
        });
      }
    }
  }

  private async seedInteractions() {
    console.log('Seeding comments, likes, and follows...');

    const postHashtagRepo = this.dataSource.getRepository(PostHashtag);
    const commentFactory = this.factoryManager.get(Comment);
    const likeRepo = this.dataSource.getRepository(Like);
    const savesPost = this.dataSource.getRepository(SavedPost);

    for (const post of this.savedPosts) {
      //** tag */
      const numTags = faker.number.int({ min: 1, max: 3 });
      const randomTags = faker.helpers.arrayElements(this.hashtags, numTags);
      for (const tag of randomTags) {
        await postHashtagRepo.save({ postId: post.id, hashtagId: tag.id });
      }

      //** comment */
      const numComments = faker.number.int({ min: 0, max: 5 });
      for (let i = 0; i < numComments; i++) {
        await commentFactory.save({
          user: faker.helpers.arrayElement(this.users),
          post,
        });
      }

      //** like */
      const numLikes = faker.number.int({ min: 2, max: 10 });
      const randomLikers = faker.helpers.arrayElements(this.users, numLikes);
      for (const liker of randomLikers) {
        await likeRepo.save({ postId: post.id, userId: liker.id });
      }

      //** bookmark */
      const numSaves = faker.number.int({ min: 0, max: 5 });
      const randomSavers = faker.helpers.arrayElements(this.users, numSaves);
      for (const saver of randomSavers) {
        await savesPost.save({ postId: post.id, userId: saver.id });
      }
    }
  }

  private async seedFollows() {
    console.log('Seeding follows...');

    const followRepo = this.dataSource.getRepository(Follow);
    for (const user of this.users) {
      const numFollowers = faker.number.int({ min: 0, max: 5 });
      const otherUsers = this.users.filter((u) => u.id !== user.id);
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
  }
}
