'use client';

import { cn } from '@workspace/ui/lib/utils';
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
import SubmitButton from '@/app/auth/components/submit-button';
import { login } from '@/app/auth/lib/auth';
import { useActionState } from 'react';

export function LoginForm({
  className,
  ...props
}: React.ComponentProps<'div'>) {
  const [state, action] = useActionState(login, undefined);
  return (
    <div className={cn('flex flex-col gap-6', className)} {...props}>
      <Card>
        <CardHeader>
          <CardTitle>Login to your account</CardTitle>
          <CardDescription>
            Enter your email below to login to your account
          </CardDescription>
        </CardHeader>
        <CardContent>
          <form action={action}>
            <FieldGroup>
              {state?.message && (
                <p className="text-sm text-red-500">{state.message}</p>
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
              </Field>
              {state?.error?.email && (
                <p className="text-sm text-red-500">{state.error.email}</p>
              )}
              <Field>
                <div className="flex items-center">
                  <FieldLabel htmlFor="password">Password</FieldLabel>
                  <a
                    href="#"
                    className="ml-auto inline-block text-sm underline-offset-4 hover:underline"
                  >
                    Forgot your password?
                  </a>
                </div>
                <Input id="password" name="password" type="password" required />
              </Field>
              {state?.error?.password && (
                <p className="text-sm text-red-500">{state.error.password}</p>
              )}
              <Field>
                <SubmitButton text="Sign In" loadingText="Authenticating..." />
                <Button variant="outline" type="button">
                  Login with Google
                </Button>
                <FieldDescription className="text-center">
                  Don&apos;t have an account? <a href="/auth/signup">Sign up</a>
                </FieldDescription>
              </Field>
            </FieldGroup>
          </form>
        </CardContent>
      </Card>
    </div>
  );
}
