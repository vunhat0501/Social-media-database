import { Auth } from '@/auth/entities/auth.entity';
import { faker } from '@faker-js/faker';
import { setSeederFactory } from 'typeorm-extension';

export default setSeederFactory(Auth, () => {
  const auth = new Auth();
  auth.hashedPassword = faker.internet.password({ length: 20 });
  auth.refreshToken = faker.string.alphanumeric(20);
  auth.authProvider = faker.helpers.arrayElement(['local', 'google', 'apple']);
  auth.authProviderId = faker.string.alphanumeric(20);
  auth.emailVerified = faker.datatype.boolean();
  return auth;
});
