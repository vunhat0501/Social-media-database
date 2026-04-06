import js from '@eslint/js';
import eslintConfigPrettier from 'eslint-config-prettier';
import onlyWarn from 'eslint-plugin-only-warn';
import turboPlugin from 'eslint-plugin-turbo';
import tseslint from 'typescript-eslint';

/**
 * A shared ESLint configuration for the repository.
 *
 * @type {import("eslint").Linter.Config}
 * */
export const config = [
  js.configs.recommended,
  eslintConfigPrettier,
  ...tseslint.configs.recommended,
  {
    plugins: {
      turbo: turboPlugin,
    },
    rules: {
      'turbo/no-undeclared-env-vars': 'warn',
      'prefer-const': 'warn',
      'no-const-assign': 'error',
      'no-var': 'error',
      'no-new-object': 'warn',
      'object-shorthand': 'warn',
      'prefer-object-spread': 'warn',
      'prefer-destructuring': 'error',
      'prefer-template': 'warn',
      'default-param-last': 'error',
      'no-param-reassign': 'error',
      'prefer-spread': 'warn',
      'prefer-arrow-callback': 'error',
      'no-useless-constructor': 'error',
      'class-methods-use-this': 'error',
      'no-duplicate-imports': 'warn',
    },
  },
  {
    plugins: {
      onlyWarn,
    },
  },
  {
    ignores: ['dist/**'],
  },
];
