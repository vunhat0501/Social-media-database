'use client';
import { ProfileActions } from '@/app/(protected)/profile/components/profile-actions';
import { ProfileHeader } from '@/app/(protected)/profile/components/profile-header';
import { ProfileStats } from '@/app/(protected)/profile/components/profile-stats';
import { useAuthStore } from '@/store/useAuthStore';
import { ProfileData } from '@workspace/types';
import { Card, CardContent } from '@workspace/ui/components/card';

import { ProfilePosts } from '@/app/(protected)/profile/components/profile-posts';

interface ProfileCardProps {
  profileData: ProfileData;
}

export function ProfileCard({ profileData }: ProfileCardProps) {
  const { user } = useAuthStore();
  const isOwnProfile = user?.name === profileData.userName;

  return (
    <div className="max-w-3xl mx-auto p-4 space-y-6 pb-20">
      <Card>
        <ProfileHeader profileData={profileData} isOwnProfile={isOwnProfile} />
        <CardContent className="space-y-4">
          <ProfileStats />
          <ProfileActions isOwnProfile={isOwnProfile} />
        </CardContent>
      </Card>
      
      {/* Grid bài viết của người dùng */}
      <ProfilePosts profileData={profileData} />
    </div>
  );
}
