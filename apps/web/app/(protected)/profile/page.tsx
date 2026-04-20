'use client';

import { useAuthStore } from '@/store/useAuthStore';
import {
  Card,
  CardContent,
  CardHeader,
  CardTitle,
} from '@workspace/ui/components/card';
import {
  Avatar,
  AvatarFallback,
  AvatarImage,
} from '@workspace/ui/components/avatar';
import { Button } from '@workspace/ui/components/button';

export default function ProfilePage() {
  // Grab the user and loading state from Zustand
  const { user, isLoading } = useAuthStore();

  if (isLoading) {
    return <div className="p-8">Loading profile...</div>;
  }

  // If middleware is working correctly, user should never be null here,
  // but we add a safety check.
  if (!user) return null;

  return (
    <div className="max-w-2xl mx-auto p-4 space-y-6">
      <Card>
        <CardHeader className="flex flex-row items-center gap-4">
          <Avatar className="h-20 w-20">
            <AvatarImage src="/avatars/default.jpg" />
            <AvatarFallback className="text-xl">
              {user?.name ? user.name.substring(0, 2).toUpperCase() : '??'}
            </AvatarFallback>
          </Avatar>
          <div>
            <CardTitle className="text-2xl">{user.name}</CardTitle>
            <p className="text-muted-foreground">{user.email}</p>
          </div>
        </CardHeader>
        <CardContent className="space-y-4">
          <div className="grid grid-cols-2 gap-4 text-sm">
            <div className="p-3 border rounded-lg">
              <p className="font-semibold text-muted-foreground">User ID</p>
              <p className="font-mono">{user.id}</p>
            </div>
            <div className="p-3 border rounded-lg">
              <p className="font-semibold text-muted-foreground">
                Account Status
              </p>
              <p className="text-green-500 font-medium">Verified</p>
            </div>
          </div>

          <Button variant="outline" className="w-full">
            Edit Profile
          </Button>
        </CardContent>
      </Card>
    </div>
  );
}
