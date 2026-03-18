import { join } from 'path';
import { env } from 'src/config/env.config';
import { DataSource } from 'typeorm';

export default new DataSource({
  type: 'postgres',
  url: env.DATABASE_URL,

  host: env.DB_HOST,
  port: env.DB_PORT,
  username: env.DB_USER,
  password: env.DB_PASS,
  database: env.DB_NAME,

  entities: [join(__dirname, '../**/*.entity{.ts,.js}')],
  migrations: [join(__dirname, './migrations/*{.ts,.js}')],

  //! DO NOT set synchronize to true in production
  synchronize: false,
  logging: true,
});
