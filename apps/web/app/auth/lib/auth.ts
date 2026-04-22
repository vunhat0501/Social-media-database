'use server';

import {
  FormState,
  LoginFormSchema,
  SignupFormSchema,
} from '@/app/auth/lib/type';
import { env } from '@/config/env.config';
import axios, { isAxiosError } from 'axios';
import { cookies } from 'next/headers';
import { redirect } from 'next/navigation';

export async function signUp(
  state: FormState,
  formData: FormData,
): Promise<FormState> {
  const validationFields = SignupFormSchema.safeParse(
    Object.fromEntries(formData),
  );

  if (!validationFields.success) {
    return {
      error: validationFields.error.flatten().fieldErrors,
    };
  }

  const { name, email, password } = validationFields.data;

  try {
    await axios.post(`${env.NEXT_PUBLIC_BACKEND_URL}/auth/signup`, {
      userName: name,
      email,
      password,
    });
  } catch (error) {
    if (isAxiosError(error)) {
      if (error.response?.status === 409) {
        return {
          error: {
            email: ['This email is already registered.'],
          },
          message: 'Email already exists.',
        };
      }
      return {
        message: error.response?.data.message || 'Fail to create account',
      };
    }
    return {
      message: 'Cannot connect to server. Please try again later.',
    };
  }

  redirect('/auth/login');
}

export async function login(
  state: FormState,
  formData: FormData,
): Promise<FormState> {
  const validationFields = LoginFormSchema.safeParse(
    Object.fromEntries(formData),
  );

  if (!validationFields.success) {
    return {
      error: validationFields.error.flatten().fieldErrors,
    };
  }

  const { email, password } = validationFields.data;

  try {
    const response = await axios.post(
      `${env.NEXT_PUBLIC_BACKEND_URL}/auth/signin`,
      {
        email,
        password,
      },
    );

    const setCookieHeaders = response.headers['set-cookie'];
    // console.log('raw header session: ', setCookieHeaders);

    if (setCookieHeaders && setCookieHeaders.length > 0) {
      const cookieStore = await cookies();
      setCookieHeaders.forEach((cookieString) => {
        const parts = cookieString
          .split(';')
          .map((p) => p.trim())
          .filter(Boolean);
        if (parts.length === 0) return;
        const firstPart = parts[0];
        if (!firstPart) return;

        const [namePart, valuePart] = firstPart.split('=');

        if (!namePart || valuePart === undefined) return;

        const name = namePart.trim();
        const value = valuePart.trim();

        if (!name || !value) return;

        const maxAgePart = parts.find(
          (p) => p && p.toLowerCase().startsWith('max-age='),
        );

        let maxAge = 60 * 60; // Default 1 hour

        if (maxAgePart) {
          const splitMaxAge = maxAgePart.split('=');
          if (splitMaxAge.length === 2 && splitMaxAge[1]) {
            const parsed = parseInt(splitMaxAge[1], 10);
            if (!isNaN(parsed)) {
              maxAge = parsed;
            }
          }
        }

        cookieStore.set(name, value, {
          httpOnly: true,
          secure: env.NODE_ENV === 'production',
          sameSite: 'lax',
          path: '/',
          maxAge,
        });
      });
    }
  } catch (error) {
    if (isAxiosError(error)) {
      if (error.response?.status === 404) {
        return {
          error: {
            email: ['This email is not registered.'],
          },
          message: 'Email not found.',
        };
      }

      if (error.response?.status === 401) {
        return {
          error: { password: ['Incorrect password.'] },
          message: 'Invalid credentials.',
        };
      }

      return {
        message: error.response?.data.message || 'Fail to login',
      };
    }
    return {
      message: 'Cannot connect to server. Please try again later.',
    };
  }

  redirect('/profile');
}

export async function logout() {
  const cookieStore = await cookies();
  cookieStore.delete('access_token');
  cookieStore.delete('refresh_token');
  redirect('/auth/login');
}
