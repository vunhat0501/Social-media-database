# Structure

`npx -y tree-cli -l 9 --ignore "node_modules,.git,dist,build,.turbo" -o structure.md`

```markdown
├── apps
| ├── api
| | ├── eslint.config.mjs
| | ├── jest.config.ts
| | ├── nest-cli.json
| | ├── package.json
| | ├── README.md
| | ├── src
| | | ├── app.controller.spec.ts
| | | ├── app.controller.ts
| | | ├── app.module.ts
| | | ├── app.service.ts
| | | ├── auth
| | | | ├── auth.controller.spec.ts
| | | | ├── auth.controller.ts
| | | | ├── auth.module.ts
| | | | ├── auth.service.spec.ts
| | | | ├── auth.service.ts
| | | | ├── dto
| | | | | ├── create-auth.dto.ts
| | | | | ├── login.dto.ts
| | | | | └── update-auth.dto.ts
| | | | └── entities
| | | | └── auth.entity.ts
| | | ├── bookmarks
| | | | ├── bookmarks.controller.spec.ts
| | | | ├── bookmarks.controller.ts
| | | | ├── bookmarks.module.ts
| | | | ├── bookmarks.service.spec.ts
| | | | ├── bookmarks.service.ts
| | | | └── entities
| | | | ├── hashtag.entity.ts
| | | | ├── post-hashtag.entity.ts
| | | | └── saved-post.entity.ts
| | | ├── common
| | | | ├── filter
| | | | | └── all-exception
| | | | | ├── all-exception.filter.spec.ts
| | | | | └── all-exception.filter.ts
| | | | ├── interceptor
| | | | | ├── timeout
| | | | | | ├── timeout.interceptor.spec.ts
| | | | | | └── timeout.interceptor.ts
| | | | | └── transform
| | | | | ├── transform.interceptor.spec.ts
| | | | | └── transform.interceptor.ts
| | | | └── middleware
| | | | └── logger
| | | | ├── logger.middleware.spec.ts
| | | | └── logger.middleware.ts
| | | ├── config
| | | | ├── db.config.ts
| | | | └── env.config.ts
| | | ├── database
| | | | ├── data-source.ts
| | | | ├── database.module.ts
| | | | ├── factories
| | | | | ├── auth.factory.ts
| | | | | ├── comment.factory.ts
| | | | | ├── hashtag.factory.ts
| | | | | ├── post-media.factory.ts
| | | | | ├── post.factory.ts
| | | | | ├── story.factory.ts
| | | | | └── user.factory.ts
| | | | ├── migrations
| | | | | └── 1775741091591-InitSchema.ts
| | | | ├── seed.ts
| | | | └── seeds
| | | | └── main.seeder.ts
| | | ├── main.ts
| | | ├── posts
| | | | ├── dto
| | | | | ├── create-post.dto.ts
| | | | | └── update-post.dto.ts
| | | | ├── entities
| | | | | ├── post-media.entity.ts
| | | | | └── post.entity.ts
| | | | ├── posts.controller.spec.ts
| | | | ├── posts.controller.ts
| | | | ├── posts.module.ts
| | | | ├── posts.service.spec.ts
| | | | └── posts.service.ts
| | | ├── social
| | | | ├── entities
| | | | | ├── comment.entity.ts
| | | | | ├── follow.entity.ts
| | | | | └── like.entity.ts
| | | | ├── social.controller.spec.ts
| | | | ├── social.controller.ts
| | | | ├── social.module.ts
| | | | ├── social.service.spec.ts
| | | | └── social.service.ts
| | | ├── stories
| | | | ├── dto
| | | | | ├── create-story.dto.ts
| | | | | └── update-story.dto.ts
| | | | ├── entities
| | | | | └── story.entity.ts
| | | | ├── stories.controller.spec.ts
| | | | ├── stories.controller.ts
| | | | ├── stories.module.ts
| | | | ├── stories.service.spec.ts
| | | | └── stories.service.ts
| | | └── user
| | | ├── dto
| | | | ├── create-user.dto.ts
| | | | └── update-user.dto.ts
| | | ├── entities
| | | | └── user.entity.ts
| | | ├── user.controller.spec.ts
| | | ├── user.controller.ts
| | | ├── user.module.ts
| | | ├── user.service.spec.ts
| | | └── user.service.ts
| | ├── test
| | | ├── app.e2e-spec.ts
| | | └── jest-e2e.json
| | ├── tsconfig.build.json
| | └── tsconfig.json
| └── web
| ├── app
| | ├── favicon.ico
| | ├── layout.tsx
| | └── page.tsx
| ├── components
| | ├── login-form.tsx
| | └── providers.tsx
| ├── components.json
| ├── config
| | └── env.config.ts
| ├── coverage
| | ├── clover.xml
| | ├── coverage-final.json
| | ├── lcov-report
| | | ├── base.css
| | | ├── block-navigation.js
| | | ├── favicon.png
| | | ├── index.html
| | | ├── page.tsx.html
| | | ├── prettify.css
| | | ├── prettify.js
| | | ├── sort-arrow-sprite.png
| | | └── sorter.js
| | └── lcov.info
| ├── eslint.config.js
| ├── hooks
| ├── jest.config.ts
| ├── jest.setup.ts
| ├── lib
| ├── next-env.d.ts
| ├── next.config.mjs
| ├── package.json
| ├── postcss.config.mjs
| ├── README.md
| ├── tsconfig.json
| └── **tests**
| └── page.test.tsx
├── docker-compose.yml
├── eslint.config.mjs
├── package.json
├── packages
| ├── eslint-config
| | ├── base.js
| | ├── nest.js
| | ├── next.js
| | ├── package.json
| | ├── prettier-base.js
| | ├── react-internal.js
| | └── README.md
| ├── jest-config
| | ├── package.json
| | ├── src
| | | ├── base.ts
| | | ├── entry.ts
| | | ├── nest.ts
| | | └── next.ts
| | └── tsconfig.json
| ├── typescript-config
| | ├── base.json
| | ├── nestjs.json
| | ├── nextjs.json
| | ├── package.json
| | ├── react-library.json
| | └── README.md
| └── ui
| ├── components.json
| ├── eslint.config.js
| ├── package.json
| ├── postcss.config.mjs
| ├── src
| | ├── components
| | | ├── button.tsx
| | | ├── card.tsx
| | | ├── field.tsx
| | | ├── input.tsx
| | | ├── label.tsx
| | | └── separator.tsx
| | ├── hooks
| | ├── lib
| | | └── utils.ts
| | └── styles
| | └── globals.css
| ├── tsconfig.json
| └── tsconfig.lint.json
├── pnpm-lock.yaml
├── pnpm-workspace.yaml
├── README.md
├── structure.md
├── tools
| └── db
| ├── archives
| | ├── backup_20260411184446.sql
| | └── backup_20260413081203.sql
| ├── backup.bat
| └── rollback.bat
├── tsconfig.json
└── turbo.json
```
