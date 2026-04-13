import { User } from '@/user/entities/user.entity';
import { setSeederFactory } from 'typeorm-extension';
import { faker } from '@faker-js/faker';

export default setSeederFactory(User, () => {
  const user = new User();

  user.userName = faker.internet.userName() + faker.string.alphanumeric(5);
  user.email = faker.internet.email();
  user.avatarUrl = faker.image.avatar();
  user.bio = faker.person.bio();

  return user;
});
