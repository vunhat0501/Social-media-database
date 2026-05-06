import { SettingsCard } from '@/app/(protected)/account-settings/components/settings-card';
import React from 'react';

const AccountSettings = () => {
  return (
    <main className="max-w-2xl mx-auto p-6 space-y-6">
      <div>
        <h1 className="text-3xl font-bold tracking-tight">Account Settings</h1>
        <p className="text-muted-foreground text-sm">
          Manage your account preferences and settings.
        </p>
      </div>
      <SettingsCard />
    </main>
  );
};

export default AccountSettings;
