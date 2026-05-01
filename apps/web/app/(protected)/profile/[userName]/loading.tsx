import { Card, CardContent, CardHeader } from '@workspace/ui/components/card';
import { Skeleton } from '@workspace/ui/components/skeleton';

export default function ProfileLoading() {
  return (
    <div className="max-w-2xl mx-auto p-4 space-y-6">
      <Card>
        <CardHeader className="flex flex-row items-center gap-4">
          {/* Avatar Skeleton */}
          <Skeleton className="h-20 w-20 rounded-full" />

          {/* Name and Bio Skeletons */}
          <div className="space-y-2">
            <Skeleton className="h-8 w-48" />
            <Skeleton className="h-4 w-64" />
          </div>
        </CardHeader>

        <CardContent className="space-y-4">
          {/* Stats Grid Skeletons */}
          <div className="grid grid-cols-2 gap-4 text-sm">
            <Skeleton className="h-18.5 w-full rounded-lg" />
            <Skeleton className="h-18.5 w-full rounded-lg" />
          </div>

          {/* Button Skeleton */}
          <Skeleton className="h-10 w-full" />
        </CardContent>
      </Card>
    </div>
  );
}
