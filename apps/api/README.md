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
  - [Validation](#validation)
  - [Exception Filter](#exception-filter)
  - [Middleware](#middleware)
  - [Interceptor](#interceptor)

## Description

This monorepo is based on the official [NestJS](https://github.com/nestjs/nest) TypeScript starter repository, modified to support a Turborepo architecture.

## Database Setup

NestJS strongly encourages a [Domain-Driven Design (DDD)](https://en.wikipedia.org/wiki/Domain-driven_design) architecture. Therefore, this project uses [TypeORM](https://docs.nestjs.com/techniques/database) as its primary ORM. Unlike Prisma or Drizzle, which often rely on a single global schema file, TypeORM allows you to co-locate entities within their respective feature modules and independently sync them to the database. This approach naturally aligns with DDD principles.

First, we create a dedicated [database module](./src/database/database.module.ts). While you could connect directly to the database within the root app module using `TypeOrmModule.forRoot`, extracting this logic into its own module keeps the app module clean and improves readability as the application scales.

Using a dedicated [configuration file](https://docs.nestjs.com/techniques/configuration) is the standard approach for managing database connections in NestJS. We use a [db.config](./src/config/db.config.ts) file to securely load and structure these connection variables.

For database migrations, a [DataSource](https://typeorm.io/docs/migrations/setup) file is required by the TypeORM CLI. This file instructs TypeORM on where to find your application's entities and where your migration scripts should be generated and executed.

_Note_: You can safely set `synchronize = true` in your development environment, but you must **NOT** use it in production, as it can lead to unintended data loss.

[Return to Table of Contents](#table-of-contents)

### Environment Variable Validation

When working in a team, it is easy to miss required environment variables. To prevent runtime errors, we strictly validate our environment variables using Zod.

After adding `dotenv` and `zod` to the monorepo, we parse the `.env` file against a strict Zod [schema](./src/config/env.config.ts) and export the parsed configuration. If any required variables are missing or incorrectly formatted, the server will intentionally fail to start, providing a clear error message about exactly what is missing.

_Note:_ You will notice that we use `process.cwd()` (Current Working Directory) instead of `__dirname` to locate our environment files. Because `__dirname` resolves to the file's current location (which changes once compiled into the `dist` folder), `process.cwd()` ensures NestJS consistently looks for the `.env` file at the root of the `apps/api` directory. This guarantees your config works perfectly regardless of how deep the executing file is, which is especially useful when running the app via Turborepo dev commands.

[Return to Table of Contents](#table-of-contents)

### Testing in Database

## Validation

By installing `class-validator` and `class-transformer`, NestJS provides us with powerful data transformation and [validation pipes](https://docs.nestjs.com/pipes). We set up automatic global validation using the `ValidationPipe` from `@nestjs/common`.

In this setup, we enable the three most common and secure options:

- `transform: true`: Automatically transforms incoming network payloads into real class instances typed according to our DTOs (e.g., converting a string `"25"` into a JavaScript `Number`).
- `whitelist: true`: Automatically strips any properties from the incoming object that do not have corresponding validation decorators in the DTO, preventing malicious data injection.
- `forbidNonWhitelisted: true`: Works alongside `whitelist` to throw an immediate exception if unexpected properties are detected, rather than just silently stripping them.

More options can be found in the [NestJS Validation documentation](https://docs.nestjs.com/techniques/validation#overview).

[Return to Table of Contents](#table-of-contents)

**Quick note before reading next sections:** You will always want to register your class functions (filter, interceptor, middleware, etc.) in [app.module.ts](./src/app.module.ts) when it comes to global use.

## Exception Filter

NestJS comes with a variety of built-in [exception filters](https://docs.nestjs.com/exception-filters). In this monorepo, we upgraded the "catch-all" example from the official documentation to ensure it returns meaningful error messages (like DTO validation arrays) back to the client, rather than just generic status codes.

- First, we extract the response object using `exception.getResponse()` to capture the specific error messages and payloads generated by our DTOs.
- Second, we safely handle NestJS's default error structures by checking if the extracted response is a non-null object with a `message` property. This guarantees our frontend always receives a consistent string or array, preventing silent data loss.

[Return to Table of Contents](#table-of-contents)

## Middleware

NestJS middleware are equivalent to express middleware. For more detail and explanation you can read about Nest [middleware](https://docs.nestjs.com/middleware). In this monorepo, we will first setup a basic logger middleware to track app traffic and log the methods, routes and status codes. We use `configure()` method in app.module to apply the middleware.

[Return to Table of Contents](#table-of-contents)

## Interceptor

Nestjs [interceptors](https://docs.nestjs.com/interceptors) have a set of useful capabilities which are inspired by the [Aspect Oriented Programming](https://en.wikipedia.org/wiki/Aspect-oriented_programming) (AOP) technique. In this repo, we will first create two basic interceptors: transform and timeout.

[Transform interceptor](https://docs.nestjs.com/interceptors#response-mapping) allows us to map the response object to the `data` property of a newly created object, then returning that object to frontend. By do this, frontend will only need to know and use data property without having to handle multiple name.

If you remember in the previous exception filter, we set up way to send frontend meaningful message. In Timeout interceptor, we will use one of the built-in exception: `RequestTimeoutException()` that will throw a new timeout error after certain amount of time.

[Return to Table of Contents](#table-of-contents)
