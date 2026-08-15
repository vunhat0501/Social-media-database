import { env } from '@/config/env.config';
import { cookies } from 'next/headers';
import { NextRequest, NextResponse } from 'next/server';

export async function POST(req: NextRequest) {
  const currentRefreshToken = req.cookies.get('refresh_token')?.value;
  if (!currentRefreshToken) {
    return NextResponse.json({ message: 'No refresh token' }, { status: 401 });
  }

  try {
    const backendRes = await fetch(
      `${env.NEXT_PUBLIC_BACKEND_URL}/auth/refresh`,
      {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${currentRefreshToken}`,
        },
      },
    );
    const data = await backendRes.json();
    if (!backendRes.ok) {
      console.error('NestJS Refresh Error:', data);
      return NextResponse.json(data, { status: backendRes.status });
    }

    const response = NextResponse.json({ success: true });
    const accessToken = data.data?.accessToken;
    const refreshToken = data.data?.refreshToken;
    const cookieStore = await cookies();
    cookieStore.set('access_token', accessToken, {
      httpOnly: true,
      secure: process.env.NODE_ENV === 'production',
      sameSite: 'lax',
      path: '/',
      maxAge: 15 * 60,
    });

    if (refreshToken) {
      cookieStore.set('refresh_token', refreshToken, {
        httpOnly: true,
        secure: process.env.NODE_ENV === 'production',
        sameSite: 'lax',
        path: '/',
        maxAge: 7 * 24 * 60 * 60,
      });
    }
    return response;
  } catch (error) {
    return NextResponse.json({ message: 'Unauthorized' }, { status: 401 });
  }
}
