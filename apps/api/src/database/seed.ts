import dataSource from '@/database/data-source';
import { runSeeders } from 'typeorm-extension';

console.log('Connect to database...');

dataSource
  .initialize()
  .then(async () => {
    await dataSource.synchronize(true);
    console.log('Database connected!');
    console.log('Seeding database...');
    await runSeeders(dataSource);

    console.log('Seeding done!');
    process.exit(0);
  })
  .catch((error) => {
    console.log('Error while seeding: ', error);
    process.exit(1);
  });
