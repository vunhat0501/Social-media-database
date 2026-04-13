import { Post } from '@/posts/entities/post.entity';
import { faker } from '@faker-js/faker';
import { setSeederFactory } from 'typeorm-extension';

export default setSeederFactory(Post, () => {
  const post = new Post();
  post.title = faker.lorem.sentence();
  post.status = faker.helpers.arrayElement(['public', 'private']);
  post.location = faker.location.city();

  return post;
});
