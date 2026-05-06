import dataSource from '@/database/data-source';
import { MainSeeder } from '@/database/seeds/postgres.seeder';
import { DataSource } from 'typeorm';
import { runSeeders } from 'typeorm-extension';

console.log('Connect to database...');

const seedDataSource = new DataSource({
  ...dataSource.options,
  logging: false,
});

seedDataSource
  .initialize()
  .then(async () => {
    console.log('Database connected!');
    console.log('Seeding database...');
    await runSeeders(seedDataSource, {
      seeds: [MainSeeder],
    });

    console.log('Seeding done!');
    process.exit(0);
  })
  .catch((error) => {
    console.log('Error while seeding: ', error);
    process.exit(1);
  });
