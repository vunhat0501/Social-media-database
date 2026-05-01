import { env } from '@/config/env.config';
import { NextRequest, NextResponse } from 'next/server';

export async function proxy(request: NextRequest) {
  const { pathname } = request.nextUrl;
  let accessToken = request.cookies.get('access_token')?.value;
  const refreshToken = request.cookies.get('refresh_token')?.value;

  const isAuthPage = pathname.startsWith('/auth');
  if (!accessToken && refreshToken) {
    try {
      //** Pause the request and ask NestJS for new tokens */
      const refreshRes = await fetch(
        `${env.NEXT_PUBLIC_BACKEND_URL}/auth/refresh`,
        {
          method: 'POST',
          headers: {
            Cookie: `refresh_token=${refreshToken}`,
          },
        },
      );

      if (refreshRes.ok) {
        const setCookies = refreshRes.headers.getSetCookie();
        let newAccessToken = '';

        setCookies.forEach((cookie) => {
          if (cookie.startsWith('access_token=')) {
            newAccessToken = cookie.split(';')[0].split('=')[1];
          }
        });

        if (newAccessToken) {
          accessToken = newAccessToken;

          //** Attach the new token to the incoming request so downstream
          // * Server Components can use it immediately. */
          request.cookies.set('access_token', newAccessToken);

          const response = NextResponse.next({
            request: {
              headers: request.headers,
            },
          });
          setCookies.forEach((cookie) => {
            response.headers.append('Set-Cookie', cookie);
          });

          if (isAuthPage) {
            return NextResponse.redirect(new URL('/profile', request.url));
          }

          return response;
        }
      } else {
        const response = NextResponse.redirect(
          new URL('/auth/signin', request.url),
        );
        response.cookies.delete('access_token');
        response.cookies.delete('refresh_token');
        return response;
      }
    } catch (error) {
      console.error('Middleware token refresh error:', error);
    }
  }

  const isAuthenticated = !!accessToken;

  if (isAuthPage) {
    if (isAuthenticated) {
      const referer = request.headers.get('referer');
      if (referer && !referer.includes('/auth')) {
        return NextResponse.redirect(new URL(referer));
      }
      return NextResponse.redirect(new URL('/fyp', request.url));
    }
    return NextResponse.next();
  }

  if (!isAuthenticated) {
    return NextResponse.redirect(new URL('/auth/signin', request.url));
  }

  return NextResponse.next();
}

export const config = {
  matcher: ['/((?!api|_next/static|_next/image|favicon.ico).*)'],
};
