'use client';

import { useAuthStore } from '@/store/useAuthStore';
import { Button } from '@workspace/ui/components/button';

interface ProfileActionsProps {
  isOwnProfile: boolean;
}

export function ProfileActions({ isOwnProfile }: ProfileActionsProps) {
  const { isLoading } = useAuthStore();
  if (isLoading) {
    return <div className="h-10 w-full animate-pulse rounded-md bg-muted" />;
  }
  if (isOwnProfile) {
    return (
      <Button variant="outline" className="w-full">
        Edit Profile
      </Button>
    );
  }

  return (
    <Button className="w-full bg-blue-600 hover:bg-blue-700 text-white">
      Follow
    </Button>
  );
}
