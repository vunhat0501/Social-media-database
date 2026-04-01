# NextJS monorepo with shadcn/ui

<p align="center">
  <a href="https://nextjs.org/" target="blank"><img src="https://thesvg.org/icons/nextdotjs/default.svg" width="120" alt="Next Logo" /></a>
</p>

  <p align="center">The <a href="https://react.dev/">React Framework</a> for the Web. Used by some of the world's largest companies, Next.js enables you to create high-quality web applications with the power of React components.</p>

## Table of Contents

- [NextJS monorepo with shadcn/ui](#nextjs-monorepo-with-shadcnui)
  - [Table of Contents](#table-of-contents)
  - [Manage env variables](#manage-env-variables)

## Manage env variables

We will also need a config file for nextjs to handle env variable. We will use [@t3-oss/env-nextjs](https://www.npmjs.com/package/@t3-oss/env-nextjs).  
Since nextjs has separate way to handle server and client env variables, your env config will be something like this

```typescript
import { createEnv } from '@t3-oss/env-nextjs';
import z from 'zod';

export const env = createEnv({
  server: {
    NODE_ENV: z
      .enum(['development', 'test', 'production'])
      .default('development'),
  },

  client: {},

  experimental__runtimeEnv: {
    NODE_ENV: process.env.NODE_ENV,
  },
});
```

Now turbo will require you to add `"globalEnv": ["NODE_ENV"]` or any env variable you add later on.
