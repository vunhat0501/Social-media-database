import { nestJsConfig } from '@workspace/eslint-config/nest-js';

/** @type {import("eslint").Linter.Config} */
export default [
  ...nestJsConfig,
  {
    ignores: ['.prettier.mjs', 'eslint.config.mjs'],
  },
];
