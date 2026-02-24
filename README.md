# Turborepo Template NextJS and Nest.js

This template is created base on a monorepo with shadcn/ui.

## Adding Nest.js as monorepo

- Step 1: create with monorepo with nest.js CLI

```bash
nest new api --skip-git --package-manager pnpm
```

- Step 2: Config packages
  - Step 2.1: Adding nestjs.config to typescript-config package
  - Step 2.2: Adding nest.js to eslint-config package
  - Step 2.3: Adding import typescript-config and eslint-config to api/package.json
  - Step 2.4: Update tsconfig.json and eslint.config.mjs to use shared config

## Config prettier

- Step 1: adding prettier-base.js to eslint-config package
- Step 2: adding .prettierrc.mjs to workspace and use shared config
- Step 3: update api/.prettier.mjs to use shared config

## Config Jest

- Step 1: create jest-config package for nextjs and nestjs testing
- Step 2: update apps/api/package.json
- Step 3: adding jest.config.ts to apps/api and use shared config
- Step 4: run

```bash
pnpm build --filter @workspace/jest-config
```

## Adding components

To add components to your app, run the following command at the root of your `web` app:

```bash
pnpm dlx shadcn@latest add button -c apps/web
```

This will place the ui components in the `packages/ui/src/components` directory.

## Tailwind

Your `tailwind.config.ts` and `globals.css` are already set up to use the components from the `ui` package.

## Using components

To use the components in your app, import them from the `ui` package.

```tsx
import { Button } from '@workspace/ui/components/button';
```
