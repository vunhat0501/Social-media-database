# Monorepo Architecture & Coding Standards (skill.md)

## 1. Project Overview

This project is a full-stack social application utilizing a Turborepo monorepo structure. It strictly adheres to Domain-Driven Design (DDD) principles to maintain scalable, decoupled, and highly cohesive modules.

- **Frontend**: Next.js (App Router) in `apps/web`
- **Backend**: NestJS in `apps/api`
- **Shared UI**: ShadcnUI library in `packages/ui`
- **Language**: TypeScript across the entire workspace.

---

## 2. Backend Strategy: NestJS (`apps/api`)

The backend strictly follows Domain-Driven Design. Each feature is treated as an isolated domain containing all necessary logic to function independently.

### Domain Module Structure (Local)

When generating or modifying a feature (e.g., `posts`, `social`, `bookmarks`), place all domain-specific logic inside its respective module directory:

- `src/[domain]/controllers/` & `src/[domain]/services/`: Core business logic and routing.
- `src/[domain]/entities/`: TypeORM/Database models specific to this domain.
- `src/[domain]/dto/`: Data Transfer Objects for validation.
- `src/[domain]/guards/`: Authorization guards specific to this feature.
- `src/[domain]/interceptors/`: Request/Response transformers for this domain.
- `src/[domain]/decorators/`: Custom decorators (e.g., parameter extraction) used only here.
- `src/[domain]/types/` & `src/[domain]/config/`: Domain-specific typings and configurations.

### Global/Shared Structure NestJS

Logic that applies across multiple domains or the entire application must reside outside feature modules:

- `src/common/middleware/`: Global request logging, rate limiting, etc.
- `src/common/filter/`: Global exception filters (e.g., `all-exception.filter.ts`).
- `src/common/interceptor/`: Global interceptors (e.g., `timeout`, `transform`).
- `src/config/`: Global environment and database configurations.
- `src/database/`: Shared TypeORM data-source, migrations, and seeder configurations.

### Authentication Pattern

- **Strategy**: Access/Refresh Token Rotation.
- **Implementation**: Use `passport.js` (specifically `@nestjs/passport`, `passport-jwt`, `passport-local`).
- **Strict Rule**: Do NOT use `Auth.js` or `NextAuth` for the backend auth implementation.
- **Flow**:
  1.  User authenticates via `local.strategy.ts`.
  2.  Server issues a short-lived JWT Access Token and a long-lived JWT Refresh Token.
  3.  Protected routes use `jwt-auth.guard.ts` backed by `jwt.strategy.ts`.
  4.  Token renewal uses `refresh-auth.guard.ts` backed by `refresh-jwt.strategy.ts`.

---

## 3. Frontend Strategy: Next.js (`apps/web`)

The frontend utilizes the Next.js App Router, emphasizing Route Groups for layout sharing and feature-based file colocation.

### Routing & URL Management

- **Route Groups `(...)`**: Use parentheses to group routes that share layouts without affecting the URL path.
  - _Example_: `app/(protected)/` wraps all routes requiring authentication with a shared layout (like an app sidebar) while keeping the URL clean (e.g., `/fyp` instead of `/protected/fyp`).
- **Dynamic Routing `[...]`**: Use brackets for dynamic URL segments.
  - _Example_: `app/(protected)/profile/[userId]/page.tsx` for dynamic user profiles.

### Colocation (Local Module Structure)

Each route folder should be treated as its own micro-feature. If a component, hook, or utility is _only_ used by one page, it must live inside that page's directory:

- `app/[feature]/components/`: UI components specific to this route.
- `app/[feature]/hooks/`: Custom React hooks specific to this route.
- `app/[feature]/lib/`: Helper functions or local data-fetching logic.

### Global/Shared Structure Next.js

When logic or components are shared across multiple routes, they belong in the `apps/web` root directories:

- `components/`: Reusable, composite React components (e.g., global providers, layout wrappers). Note: Basic UI elements should be imported from `@repo/ui`.
- `hooks/`: Global custom hooks (e.g., `useDebounce`, `useWindowSize`).
- `lib/`: Global utilities, API client configurations (`api.ts`), and generic helpers.
- `store/`: Global state management exclusively using **Zustand**. Examples include `useAuthStore.ts` for managing the client-side user session and token states.

---

## 4. Shared Packages (`packages/*`)

Leverage the monorepo structure to avoid duplicating configurations and core UI elements.

- `packages/ui`: Contains dumb, presentational components (Buttons, Inputs, Cards) from shadcn ui library. The Next.js app should import these instead of building new ones from scratch.
- `packages/eslint-config` & `packages/typescript-config`: Ensure any new apps or packages extend these base rules to maintain consistency.

## 5. Instructions for Coding Agents

1.  **Analyze Context Before Writing**: When asked to create a feature, determine if it belongs in a local domain folder or a global shared folder based on the rules above.
2.  **Respect Next.js File Conventions**: Always use `page.tsx`, `layout.tsx`, `loading.tsx`, and `error.tsx` correctly within the App Router paradigm.
3.  **Authentication Enforcement**: When wiring frontend to backend, rely on the NestJS Passport JWT endpoints. Update the Zustand `useAuthStore` to handle the refresh token rotation lifecycle seamlessly.
