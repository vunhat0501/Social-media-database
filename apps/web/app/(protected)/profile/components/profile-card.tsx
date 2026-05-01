'use client';
import { ProfileActions } from '@/app/(protected)/profile/components/profile-actions';
import { ProfileHeader } from '@/app/(protected)/profile/components/profile-header';
import { ProfileStats } from '@/app/(protected)/profile/components/profile-stats';
import { useAuthStore } from '@/store/useAuthStore';
import { ProfileData } from '@workspace/types';
import { Card, CardContent } from '@workspace/ui/components/card';

interface ProfileCardProps {
  profileData: ProfileData;
}

export function ProfileCard({ profileData }: ProfileCardProps) {
  const { user } = useAuthStore();
  const isOwnProfile = user?.name === profileData.userName;

  return (
    <div className="max-w-2xl mx-auto p-4 space-y-6">
      <Card>
        <ProfileHeader profileData={profileData} isOwnProfile={isOwnProfile} />
        <CardContent className="space-y-4">
          <ProfileStats />
          <ProfileActions isOwnProfile={isOwnProfile} />
        </CardContent>
      </Card>
    </div>
  );
}
