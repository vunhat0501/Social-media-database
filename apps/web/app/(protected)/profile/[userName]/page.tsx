import { ProfileCard } from '@/app/(protected)/profile/components/profile-card';
import { env } from '@/config/env.config';
import { cookies } from 'next/headers';
import { notFound } from 'next/navigation';

interface ProfilePageProps {
  params: Promise<{ userName: string }>;
}

export default async function ProfilePage({ params }: ProfilePageProps) {
  const { userName } = await params;
  const cookieStore = await cookies();
  const accessToken = cookieStore.get('access_token')?.value;
  const res = await fetch(
    `${env.NEXT_PUBLIC_BACKEND_URL}/users/profile/${userName}`,
    {
      headers: {
        'Content-Type': 'application/json',
        ...(accessToken ? { Cookie: `access_token=${accessToken}` } : {}),
      },
      cache: 'no-store',
    },
  );

  if (!res.ok) {
    if (res.status === 401 || res.status === 404) {
      return notFound();
    }
    throw new Error('Failed to fetch profile data');
  }
  const { data: profileData } = await res.json();

  return <ProfileCard profileData={profileData} />;
}
