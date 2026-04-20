import { AppSidebar } from '@/app/(protected)/components/app-sidebar';
import AuthProvider from '@/components/authProvider';
import {
  SidebarProvider,
  SidebarTrigger,
} from '@workspace/ui/components/sidebar';

export default function ProtectedLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <AuthProvider>
      <SidebarProvider>
        <AppSidebar />
        <main className="flex-1 w-full relative">
          <div className="p-4 md:hidden">
            <SidebarTrigger />
          </div>
          <div className="p-4">{children}</div>
        </main>
      </SidebarProvider>
    </AuthProvider>
  );
}
