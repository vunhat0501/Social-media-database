# NestJS Monorepo with TypeORM

<p align="center">
  <a href="http://nestjs.com/" target="blank"><img src="https://nestjs.com/img/logo-small.svg" width="120" alt="Nest Logo" /></a>
</p>

  <p align="center">A progressive <a href="http://nodejs.org" target="_blank">Node.js</a> framework for building efficient and scalable server-side applications.</p>
    <p align="center">

## Table of Contents

- [NestJS Monorepo with TypeORM](#nestjs-monorepo-with-typeorm)
  - [Table of Contents](#table-of-contents)
  - [Description](#description)
  - [Database Setup](#database-setup)
    - [Environment Variable Validation](#environment-variable-validation)
    - [Testing in Database](#testing-in-database)

## Description

This monorepo is based on the official [NestJS](https://github.com/nestjs/nest) TypeScript starter repository, modified to support a Turborepo architecture.

## Database Setup

NestJS strongly encourages a [Domain-Driven Design (DDD)](https://en.wikipedia.org/wiki/Domain-driven_design) architecture. Therefore, this project uses [TypeORM](https://docs.nestjs.com/techniques/database) as its primary ORM. Unlike Prisma or Drizzle, which often rely on a single global schema file, TypeORM allows you to co-locate entities within their respective feature modules and independently sync them to the database. This approach naturally aligns with DDD principles.

First, we create a dedicated [database module](./src/database/database.module.ts). While you could connect directly to the database within the root app module using `TypeOrmModule.forRoot`, extracting this logic into its own module keeps the app module clean and improves readability as the application scales.

Using a dedicated [configuration file](https://docs.nestjs.com/techniques/configuration) is the standard approach for managing database connections in NestJS. We use a [db.config](./src/config/db.config.ts) file to securely load and structure these connection variables.

For database migrations, a [DataSource](https://typeorm.io/docs/migrations/setup) file is required by the TypeORM CLI. This file instructs TypeORM on where to find your application`s entities and where your migration scripts should be generated and executed.

_Note_: You can safely set `synchronize = true` in your development environment, but you must **NOT** use it in production, as it can lead to unintended data loss.

[Return to Table of Contents](#table-of-contents)

### Environment Variable Validation

When working in a team, it is easy to miss required environment variables. To prevent runtime errors, we strictly validate our environment variables using Zod.

After adding `dotenv` and `zod` to the monorepo, we parse the `.env` file against a strict Zod [schema](./src/config/env.config.ts) and export the parsed configuration. If any required variables are missing or incorrectly formatted, the server will intentionally fail to start, providing a clear error message about exactly what is missing.

_Note:_ You will notice that we use `process.cwd()` (Current Working Directory) instead of `__dirname` to locate our environment files. Because `__dirname` resolves to the file's current location (which changes once compiled into the `dist` folder), `process.cwd()` ensures NestJS consistently looks for the `.env` file at the root of the `apps/api` directory. This guarantees your config works perfectly regardless of how deep the executing file is, which is especially useful when running the app via Turborepo dev commands.

[Return to Table of Contents](#table-of-contents)

### Testing in Database
