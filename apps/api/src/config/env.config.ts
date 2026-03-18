import { config } from 'dotenv';
import { existsSync } from 'fs';
import { resolve } from 'path';
import z from 'zod';

const envPath = resolve(process.cwd(), '../../.env');

if (!existsSync(envPath)) {
  throw new Error(`FATAL: .env file not found. Expected in: ${envPath}`);
}

config({ path: envPath });

const envSchema = z.object({
  DATABASE_URL: z
    .string({
      required_error: 'DATABASE_URL is required',
      invalid_type_error: 'DATABASE_URL must be a string',
      message: 'Please add database URL to .env file',
    })
    .url('DATABASE_URL must be a valid url'),

  //** These database variables is optional in case using database hosting like Neon */
  DB_HOST: z.string().default('localhost'),
  DB_PORT: z.coerce.number().default(5432),
  DB_USER: z.string().default('postgres'),
  DB_PASS: z.string().default('postgres'),
  DB_NAME: z.string().default('postgres'),
  NODE_ENV: z
    .enum(['development', 'production', 'test'])
    .default('development'),
});

export const env = envSchema.parse(process.env);
