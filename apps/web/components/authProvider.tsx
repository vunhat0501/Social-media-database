'use client';

import { useAuthStore } from '@/store/useAuthStore';
import { useEffect } from 'react';

export default function AuthProvider({
  children,
}: {
  children: React.ReactNode;
}) {
  const checkSession = useAuthStore((state) => state.checkSession);

  useEffect(() => {
    checkSession();
  }, [checkSession]);

  return <>{children}</>;
}
