import { Hashtag } from '@/bookmarks/entities/hashtag.entity';
import { faker } from '@faker-js/faker';
import { setSeederFactory } from 'typeorm-extension';

export default setSeederFactory(Hashtag, () => {
  const hashtag = new Hashtag();
  hashtag.name = faker.lorem.word() + faker.string.alphanumeric(3);

  return hashtag;
});
