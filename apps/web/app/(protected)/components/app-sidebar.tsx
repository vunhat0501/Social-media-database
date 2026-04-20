'use client'; // Required for usePathname

import { usePathname, useRouter } from 'next/navigation';
import {
  Sparkles,
  User as UserIcon,
  Settings,
  LogOut,
  ChevronsUpDown,
  Hash,
} from 'lucide-react';

import {
  Sidebar,
  SidebarContent,
  SidebarFooter,
  SidebarGroup,
  SidebarGroupContent,
  SidebarGroupLabel,
  SidebarHeader,
  SidebarMenu,
  SidebarMenuButton,
  SidebarMenuItem,
} from '@workspace/ui/components/sidebar';
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from '@workspace/ui/components/dropdown-menu';
import {
  Avatar,
  AvatarFallback,
  AvatarImage,
} from '@workspace/ui/components/avatar';
import { useAuthStore } from '@/store/useAuthStore';

const navItems = [
  { title: 'For You', url: '/fyp', icon: Sparkles },
  { title: 'Explore', url: '/explore', icon: Hash },
  { title: 'Profile', url: '/profile', icon: UserIcon },
];

export function AppSidebar() {
  const pathname = usePathname();
  const router = useRouter();
  const { user, logout } = useAuthStore();

  const handleLogout = async () => {
    await logout();
    router.push('/auth/login');
  };

  return (
    <Sidebar variant="inset">
      <SidebarHeader className="h-16 flex items-center justify-center border-b px-4">
        <div className="flex w-full items-center gap-2 font-bold text-lg tracking-tight">
          <div className="flex h-8 w-8 items-center justify-center rounded-lg bg-primary text-primary-foreground">
            <Sparkles className="h-5 w-5" />
          </div>
          <span>Social App</span>
        </div>
      </SidebarHeader>

      <SidebarContent>
        <SidebarGroup>
          <SidebarGroupLabel className="mt-4 text-xs font-semibold tracking-wider text-muted-foreground uppercase">
            Feeds
          </SidebarGroupLabel>
          <SidebarGroupContent>
            <SidebarMenu>
              {navItems.map((item) => {
                const isActive = pathname === item.url;

                return (
                  <SidebarMenuItem key={item.title}>
                    <SidebarMenuButton
                      asChild
                      isActive={isActive}
                      tooltip={item.title}
                    >
                      <a href={item.url}>
                        <item.icon className="h-4 w-4" />
                        <span>{item.title}</span>
                      </a>
                    </SidebarMenuButton>
                  </SidebarMenuItem>
                );
              })}
            </SidebarMenu>
          </SidebarGroupContent>
        </SidebarGroup>
      </SidebarContent>

      <SidebarFooter className="border-t p-4">
        <SidebarMenu>
          <SidebarMenuItem>
            <DropdownMenu>
              <DropdownMenuTrigger asChild>
                <SidebarMenuButton
                  size="lg"
                  className="data-[state=open]:bg-sidebar-accent data-[state=open]:text-sidebar-accent-foreground"
                >
                  <Avatar className="h-8 w-8 rounded-lg">
                    {/* Optional: You can make the src dynamic if your user object has an avatar URL later */}
                    <AvatarImage
                      src="/avatars/shadcn.jpg"
                      alt={user?.name || 'User Avatar'}
                    />
                    <AvatarFallback className="rounded-lg">
                      {/* Grabs the first two letters of their name, or defaults to "U" */}
                      {user?.name?.substring(0, 2).toUpperCase() || 'U'}
                    </AvatarFallback>
                  </Avatar>
                  {/* TODO: Use real user data */}
                  <div className="grid flex-1 text-left text-sm leading-tight">
                    {user ? (
                      <>
                        <span className="truncate font-semibold">
                          {user.name}
                        </span>
                        <span className="truncate text-xs text-muted-foreground">
                          {user.email}
                        </span>
                      </>
                    ) : (
                      <div className="space-y-2">
                        <div className="h-3 w-24 animate-pulse rounded bg-muted" />
                        <div className="h-2 w-32 animate-pulse rounded bg-muted" />
                      </div>
                    )}
                  </div>
                  <ChevronsUpDown className="ml-auto h-4 w-4" />
                </SidebarMenuButton>
              </DropdownMenuTrigger>
              <DropdownMenuContent
                className="w-[--radix-dropdown-menu-trigger-width] min-w-56 rounded-lg"
                side="right"
                align="end"
                sideOffset={4}
              >
                <DropdownMenuItem className="cursor-pointer">
                  <Settings className="mr-2 h-4 w-4" />
                  Account Settings
                </DropdownMenuItem>

                {/* Attach the onClick handler here! 
                  Added cursor-pointer so it feels like a real button 
                */}
                <DropdownMenuItem
                  onClick={handleLogout}
                  className="text-red-500 focus:text-red-500 focus:bg-red-50 dark:focus:bg-red-950 cursor-pointer"
                >
                  <LogOut className="mr-2 h-4 w-4" />
                  Log out
                </DropdownMenuItem>
              </DropdownMenuContent>
            </DropdownMenu>
          </SidebarMenuItem>
        </SidebarMenu>
      </SidebarFooter>
    </Sidebar>
  );
}
