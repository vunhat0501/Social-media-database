# NestJS Monorepo with TypeORM

<p align="center">
  <a href="http://nestjs.com/" target="blank"><img src="https://nestjs.com/img/logo-small.svg" width="120" alt="Nest Logo" /></a>
</p>

[circleci-image]: https://img.shields.io/circleci/build/github/nestjs/nest/master?token=abc123def456
[circleci-url]: https://circleci.com/gh/nestjs/nest

  <p align="center">A progressive <a href="http://nodejs.org" target="_blank">Node.js</a> framework for building efficient and scalable server-side applications.</p>
    <p align="center">

## Table of Contents

- [NestJS Monorepo with TypeORM](#nestjs-monorepo-with-typeorm)
  - [Table of Contents](#table-of-contents)
  - [Description](#description)
  - [Database set up](#database-set-up)
    - [Make sure your env variables are set correctly](#make-sure-your-env-variables-are-set-correctly)
    - [Testing in Database](#testing-in-database)

## Description

This monorepo is created base on [Nest](https://github.com/nestjs/nest) framework TypeScript starter repository with some changes in order to use turborepo.

## Database set up

Since Nestjs is a strict [Domain-drive design](https://en.wikipedia.org/wiki/Domain-driven_design) or DDD for short so this project base will be using [TypeORM](https://docs.nestjs.com/techniques/database) as in document. TypeORM allow you to extract entities from different place and migrate them to database instead of having a single schema like Prisma or Drizzle, basically TypeORM encourage you to follow and get use to DDD.

First we will create a [module](./src/database/database.module.ts) for database. You can directly connecting to database in your app module with `TypeOrmModule.forRoot` since your app grow larger this will nest your app module, reduce readability.

Create your own db [configuration](https://docs.nestjs.com/techniques/configuration) is the standard way to connect to your database. We will create a [db.config](./src/config/db.config.ts) and set it with the same variables and setting as in document.

For migration, you will want to create a [DataSource](https://typeorm.io/docs/migrations/setup) file to migrate with TypeORM CLI. This is the way to tell TypeORM where your entities are located and where your migration files will go.

_Note_: You can set synchronize = true in dev environment but **NOT** in production - otherwise you will lose your data.

[return to table of contents](#table-of-contents)

### Make sure your env variables are set correctly

When working a team and sharing env variable, sometimes you might forget some important ones. So setup a config file with zod purely to check these variable is recommended.

Adding dotenv and zod to our monorepo. Config the part to .evn file and setup a basic zod [schema](./src/config/env.config.ts) with necessary variables and export this schema in parsed. From now you will know which variables crash your server.

_Note:_ You will also notice that we use `process.cwd` which is current working directory. Since `__dirname` is relative path to your current directory, and you will definitely run your project with `pnpm run dev`, using `process.cwd` helps your nestjs find the root .env file by locking the directory to apps/api. Basically you don't have to worry about how deep your config or dist folder is.

### Testing in Database
