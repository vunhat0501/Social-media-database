import { Comment } from '@/social/entities/comment.entity';
import { faker } from '@faker-js/faker';
import { setSeederFactory } from 'typeorm-extension';

export default setSeederFactory(Comment, () => {
  const comment = new Comment();
  comment.content = faker.helpers.arrayElement([
    faker.lorem.sentence(),
    faker.lorem.paragraph(),
    faker.lorem.lines(),
    'Where is this?!',
    'This is amazing!',
    'Love this so much',
  ]);

  return comment;
});
