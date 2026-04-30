'use client';
import { useAuthStore } from '@/store/useAuthStore';
import { ProfileData } from '@workspace/types';
import {
  Avatar,
  AvatarFallback,
  AvatarImage,
} from '@workspace/ui/components/avatar';
import { Button } from '@workspace/ui/components/button';
import {
  Card,
  CardContent,
  CardHeader,
  CardTitle,
} from '@workspace/ui/components/card';

interface ProfileCardProps {
  profileData: ProfileData;
}

export function ProfileCard({ profileData }: ProfileCardProps) {
  const { user } = useAuthStore();
  const isOwnProfile = user?.name === profileData.userName;
  return (
    <div className="max-w-2xl mx-auto p-4 space-y-6">
      <Card>
        <CardHeader className="flex flex-row items-center gap-4">
          <Avatar className="h-20 w-20">
            <AvatarImage
              src={profileData.avatarUrl || '/avatars/default.jpg'}
            />
            <AvatarFallback className="text-xl">
              {profileData.userName
                ? profileData.userName.substring(0, 2).toUpperCase()
                : '??'}
            </AvatarFallback>
          </Avatar>
          <div>
            <CardTitle className="text-2xl">{profileData.userName}</CardTitle>
            {isOwnProfile && (
              <p className="text-muted-foreground">{profileData.email}</p>
            )}
            {profileData.bio && (
              <p className="mt-2 text-sm">{profileData.bio}</p>
            )}
          </div>
        </CardHeader>

        <CardContent className="space-y-4">
          <div className="grid grid-cols-2 gap-4 text-sm">
            <div className="p-3 border rounded-lg">
              <p className="font-semibold text-muted-foreground">Followers</p>
              <p className="font-mono">124</p>{' '}
              {/* Placeholder for relation data */}
            </div>
            <div className="p-3 border rounded-lg">
              <p className="font-semibold text-muted-foreground">Following</p>
              <p className="font-mono">89</p>{' '}
              {/* Placeholder for relation data */}
            </div>
          </div>

          {isOwnProfile ? (
            <Button variant="outline" className="w-full">
              Edit Profile
            </Button>
          ) : (
            <Button className="w-full bg-blue-600 hover:bg-blue-700 text-white">
              Follow
            </Button>
          )}
        </CardContent>
      </Card>
    </div>
  );
}
