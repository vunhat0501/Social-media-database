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

    // Users can still be bulk saved via the factory
    this.users = await userFactory.saveMany(1000);

    const authsToInsert = [];
    const storiesToInsert = [];

    for (const user of this.users) {
      // Create entities in memory using .make() instead of .save()
      const auth = await authFactory.make({ user });
      authsToInsert.push(auth);

      if (faker.datatype.boolean({ probability: 0.3 })) {
        const story = await storyFactory.make({ user });
        storiesToInsert.push(story);
      }
    }

    // Bulk Insert
    await this.dataSource
      .getRepository(Auth)
      .save(authsToInsert, { chunk: 100 });
    await this.dataSource
      .getRepository(Story)
      .save(storiesToInsert, { chunk: 100 });
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
    const postMediaRepo = this.dataSource.getRepository(PostMedia);

    // Bulk make and save posts
    const posts = await Promise.all(
      Array(10000)
        .fill('')
        .map(() =>
          postFactory.make({ user: faker.helpers.arrayElement(this.users) }),
        ),
    );
    this.savedPosts = await postRepo.save(posts);

    const mediaToInsert = [];

    // Add 1-5 images to every single post (Carousels)
    for (const post of this.savedPosts) {
      const numMedia = faker.number.int({ min: 1, max: 5 });
      for (let i = 0; i < numMedia; i++) {
        const media = await postMediaFactory.make({
          post,
          sequenceOrder: i + 1,
        });
        mediaToInsert.push(media);
      }
    }

    // Bulk Insert Media
    await postMediaRepo.save(mediaToInsert, { chunk: 100 });
  }

  private async seedInteractions() {
    console.log('Seeding tags, comments, likes, and bookmarks...');

    const postHashtagRepo = this.dataSource.getRepository(PostHashtag);
    const likeRepo = this.dataSource.getRepository(Like);
    const savesPostRepo = this.dataSource.getRepository(SavedPost);
    const commentRepo = this.dataSource.getRepository(Comment);
    const commentFactory = this.factoryManager.get(Comment);

    const hashtagsToInsert = [];
    const commentsToInsert = [];
    const likesToInsert = [];
    const savesToInsert = [];

    for (const post of this.savedPosts) {
      //** tag */
      const numTags = faker.number.int({ min: 1, max: 3 });
      const randomTags = faker.helpers.arrayElements(this.hashtags, numTags);
      const uniqueTagIds = [...new Set(randomTags.map((t) => t.id))]; // Prevent duplicate tags

      for (const tagId of uniqueTagIds) {
        hashtagsToInsert.push({ postId: post.id, hashtagId: tagId });
      }

      //** comment */
      const numComments = faker.number.int({ min: 0, max: 5 });
      for (let i = 0; i < numComments; i++) {
        const comment = await commentFactory.make({
          user: faker.helpers.arrayElement(this.users),
          post,
        });
        commentsToInsert.push(comment);
      }

      //** like */
      const numLikes = faker.number.int({ min: 2, max: 10 });
      const randomLikers = faker.helpers.arrayElements(this.users, numLikes);
      const uniqueLikerIds = [...new Set(randomLikers.map((u) => u.id))]; // Prevent duplicate likes

      for (const likerId of uniqueLikerIds) {
        likesToInsert.push({ postId: post.id, userId: likerId });
      }

      //** bookmark */
      const numSaves = faker.number.int({ min: 0, max: 5 });
      const randomSavers = faker.helpers.arrayElements(this.users, numSaves);
      const uniqueSaverIds = [...new Set(randomSavers.map((u) => u.id))]; // Prevent duplicate saves

      for (const saverId of uniqueSaverIds) {
        savesToInsert.push({ postId: post.id, userId: saverId });
      }
    }

    // Bulk Inserts
    await postHashtagRepo.save(hashtagsToInsert, { chunk: 100 });
    await commentRepo.save(commentsToInsert, { chunk: 100 });
    await likeRepo.save(likesToInsert, { chunk: 100 });
    await savesPostRepo.save(savesToInsert, { chunk: 100 });
  }

  private async seedFollows() {
    console.log('Seeding follows...');

    const followRepo = this.dataSource.getRepository(Follow);
    const followsToInsert = [];

    for (const user of this.users) {
      const numFollowers = faker.number.int({ min: 0, max: 5 });
      const otherUsers = this.users.filter((u) => u.id !== user.id);
      const usersToFollow = faker.helpers.arrayElements(
        otherUsers,
        numFollowers,
      );

      const uniqueFollowerIds = [...new Set(usersToFollow.map((u) => u.id))]; // Prevent duplicate follows

      for (const followerId of uniqueFollowerIds) {
        followsToInsert.push({
          followingUserId: user.id,
          followedUserId: followerId,
        });
      }
    }

    // Bulk Insert
    await followRepo.save(followsToInsert, { chunk: 100 });
  }
}
