'use client';

import { Button } from '@workspace/ui/components/button';
import { Loader2 } from 'lucide-react';
import { useFormStatus } from 'react-dom';

interface SubmitButtonProps {
  text: string;
  loadingText?: string;
}

export default function SubmitButton({
  text,
  loadingText = 'Please wait...',
}: SubmitButtonProps) {
  const { pending } = useFormStatus();

  return (
    <Button type="submit" disabled={pending} className="w-full">
      {pending ? (
        <>
          <Loader2 className="mr-2 h-4 w-4 animate-spin" />
          {loadingText}
        </>
      ) : (
        text
      )}
    </Button>
  );
}
