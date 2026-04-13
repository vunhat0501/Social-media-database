import { Story } from '@/stories/entities/story.entity';
import { faker } from '@faker-js/faker';
import { setSeederFactory } from 'typeorm-extension';

export default setSeederFactory(Story, () => {
  const story = new Story();
  story.mediaUrl = faker.image.urlPicsumPhotos({ width: 1080, height: 1920 });
  story.expiresAt = faker.date.soon({ days: 1 });

  return story;
});
