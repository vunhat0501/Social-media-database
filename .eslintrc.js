// This configuration only applies to the package manager root.
/** @type {import("eslint").Linter.Config} */
module.exports = {
  ignorePatterns: ['apps/**', 'packages/**', 'dist/**', 'node_modules/**'],
  extends: ['@workspace/eslint-config/library.js'],
  parser: '@typescript-eslint/parser',
  parserOptions: {
    project: true,
  },
  rules: {
    // add override for any (a metric ton of them, initial conversion)
    '@typescript-eslint/no-explicit-any': 'off',
    // we generally use this in isFunction, not via calling
    '@typescript-eslint/unbound-method': 'off',
  },
};
