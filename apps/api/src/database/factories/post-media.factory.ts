import { PostMedia } from '@/posts/entities/post-media.entity';
import { faker } from '@faker-js/faker';
import { setSeederFactory } from 'typeorm-extension';

export default setSeederFactory(PostMedia, () => {
  const postMedia = new PostMedia();
  postMedia.mediaType = faker.helpers.arrayElement(['image', 'video']);
  postMedia.mediaUrl = faker.image.urlPicsumPhotos();

  return postMedia;
});
