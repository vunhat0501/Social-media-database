import { NextRequest, NextResponse } from 'next/server';

export function proxy(request: NextRequest) {
  const { pathname } = request.nextUrl;
  const accessToken = request.cookies.get('access_token')?.value;
  const refreshToken = request.cookies.get('refresh_token')?.value;

  const isAuthenticated = !!accessToken;
  const canRefresh = !!refreshToken;
  const isAuthPage = pathname.startsWith('/auth');

  if (isAuthPage) {
    if (isAuthenticated || canRefresh) {
      // Redirect to previous page if available and not an auth page, otherwise default to /profile
      const referer = request.headers.get('referer');
      if (referer && !referer.includes('/auth')) {
        return NextResponse.redirect(new URL(referer));
      }
      return NextResponse.redirect(new URL('/profile', request.url));
    }
    return NextResponse.next();
  }

  if (!isAuthenticated && !canRefresh) {
    return NextResponse.redirect(new URL('/auth/signin', request.url));
  }

  return NextResponse.next();
}

export const config = {
  matcher: ['/((?!api|_next/static|_next/image|favicon.ico).*)'],
};
