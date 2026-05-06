import { ProfileData } from '@workspace/types';
import {
  Avatar,
  AvatarFallback,
  AvatarImage,
} from '@workspace/ui/components/avatar';
import { CardHeader, CardTitle } from '@workspace/ui/components/card';

interface ProfileHeaderProps {
  profileData: ProfileData;
  isOwnProfile: boolean;
}

export function ProfileHeader({
  profileData,
  isOwnProfile,
}: ProfileHeaderProps) {
  return (
    <CardHeader className="flex flex-row items-center gap-4">
      <Avatar className="h-20 w-20">
        <AvatarImage src={profileData.avatarUrl || '/avatars/default.jpg'} />
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
        {profileData.bio && <p className="mt-2 text-sm">{profileData.bio}</p>}
      </div>
    </CardHeader>
  );
}
