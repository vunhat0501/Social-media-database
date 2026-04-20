import z from 'zod';

export type FormState =
  | {
      error?: {
        name?: string[];
        email?: string[];
        password?: string[];
        confirmPassword?: string[];
      };
      message?: string;
    }
  | undefined;

export const SignupFormSchema = z
  .object({
    name: z
      .string()
      .min(2, { message: 'Name must be at least 2 characters long.' })
      .trim(),

    email: z.string().email({ message: 'Invalid email address.' }).trim(),

    password: z
      .string()
      .min(8, { message: 'Password must be at least 8 characters long.' })
      .regex(/[a-zA-Z]/, { message: 'Contain at least one letter.' })
      .regex(/[0-9]/, { message: 'Contain at least one number.' })
      .regex(/[^a-zA-Z0-9]/, {
        message: 'Contain at least one special character.',
      }),

    confirmPassword: z.string(),
  })
  .refine((data) => data.password === data.confirmPassword, {
    message: 'Passwords do not match.',
    path: ['confirmPassword'],
  });

export const LoginFormSchema = z.object({
  email: z.string().email({ message: 'Invalid email address.' }).trim(),

  password: z.string().min(1, { message: 'Password is required.' }),
});
