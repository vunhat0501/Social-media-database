'use client';

import { signUp } from '@/app/auth/lib/auth';
import SubmitButton from '@/app/auth/components/submit-button';
import { Button } from '@workspace/ui/components/button';
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from '@workspace/ui/components/card';
import {
  Field,
  FieldDescription,
  FieldGroup,
  FieldLabel,
} from '@workspace/ui/components/field';
import { Input } from '@workspace/ui/components/input';
import { useActionState } from 'react';

export function SignupForm({ ...props }: React.ComponentProps<typeof Card>) {
  const [state, action] = useActionState(signUp, undefined);
  return (
    <Card {...props}>
      <CardHeader>
        <CardTitle>Create an account</CardTitle>
        <CardDescription>
          Enter your information below to create your account
        </CardDescription>
      </CardHeader>
      <CardContent>
        <form action={action}>
          <FieldGroup>
            {state?.message && (
              <p className="text-sm text-red-500">{state.message}</p>
            )}
            <Field>
              <FieldLabel htmlFor="name">Full Name</FieldLabel>
              <Input
                id="name"
                name="name"
                type="text"
                placeholder="John Doe"
                required
              />
            </Field>
            {state?.error?.name && (
              <p className="text-sm text-red-500">{state.error.name}</p>
            )}
            <Field>
              <FieldLabel htmlFor="email">Email</FieldLabel>
              <Input
                id="email"
                name="email"
                type="email"
                placeholder="m@example.com"
                required
              />
              <FieldDescription>
                We&apos;ll use this to contact you. We will not share your email
                with anyone else.
              </FieldDescription>
            </Field>
            {state?.error?.email && (
              <p className="text-sm text-red-500">{state.error.email}</p>
            )}
            <Field>
              <FieldLabel htmlFor="password">Password</FieldLabel>
              <Input id="password" name="password" type="password" required />
              <FieldDescription>
                Must be at least 8 characters long.
              </FieldDescription>
            </Field>
            {state?.error?.password && (
              <div className="text-sm text-red-500">
                <p>Password must:</p>
                <ul>
                  {state.error.password.map((error) => (
                    <li key={error}>{error}</li>
                  ))}
                </ul>
              </div>
            )}
            <Field>
              <FieldLabel htmlFor="confirm-password">
                Confirm Password
              </FieldLabel>
              <Input
                id="confirm-password"
                name="confirmPassword"
                type="password"
                required
              />
              <FieldDescription>Please confirm your password.</FieldDescription>
            </Field>
            {state?.error?.confirmPassword && (
              <p className="text-sm text-red-500">
                {state.error.confirmPassword}
              </p>
            )}
            <FieldGroup>
              <Field>
                <SubmitButton
                  text="Create Account"
                  loadingText="Creating Account..."
                />
                <Button variant="outline" type="button">
                  Sign up with Google
                </Button>
                <FieldDescription className="px-6 text-center">
                  Already have an account? <a href="/auth/login">Sign in</a>
                </FieldDescription>
              </Field>
            </FieldGroup>
          </FieldGroup>
        </form>
      </CardContent>
    </Card>
  );
}
