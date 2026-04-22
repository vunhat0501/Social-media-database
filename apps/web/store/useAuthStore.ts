import { logout } from '@/app/auth/lib/auth';
import { api } from '@/lib/api';
import { create } from 'zustand';

interface User {
  id: string;
  email: string;
  name: string;
}

interface AuthState {
  user: User | null;
  isAuthenticated: boolean;
  isLoading: boolean;

  signIn: (credentials: any) => Promise<void>;
  login: (userData: User) => void;
  logout: () => Promise<void>;
  checkSession: () => Promise<void>;
}

export const useAuthStore = create<AuthState>((set) => ({
  user: null,
  isAuthenticated: false,
  isLoading: true,

  signIn: async (credentials) => {
    try {
      const response = await api.post('/auth/signin', credentials);
      const userData = response.data;
      set({ user: userData, isAuthenticated: true, isLoading: false });
    } catch (error) {
      console.error('Login error:', error);
      throw error;
    }
  },

  login: (userData: User) =>
    set({ user: userData, isAuthenticated: true, isLoading: false }),

  logout: async () => {
    try {
      await api.post('/auth/signout');
    } catch (error) {
      console.error('Logout error:', error);
    } finally {
      await logout();
      set({ user: null, isAuthenticated: false, isLoading: false });
    }
  },

  checkSession: async () => {
    try {
      const response = await api.get('/auth/me');
      const userData = response.data.data;
      if (userData) {
        set({ user: userData, isAuthenticated: true, isLoading: false });
      }
    } catch (error) {
      set({ user: null, isAuthenticated: false, isLoading: false });
    }
  },
}));
