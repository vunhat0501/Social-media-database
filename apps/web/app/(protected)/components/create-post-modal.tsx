'use client';

import React, { useState } from 'react';
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from '@workspace/ui/components/dialog';
import { Button } from '@workspace/ui/components/button';
import { Textarea } from '@workspace/ui/components/textarea';
import { Input } from '@workspace/ui/components/input';
import { Sparkles, MapPin, Globe, Image as ImageIcon, Lock } from 'lucide-react';
import { api } from '@/lib/api';
import { useRouter } from 'next/navigation';

export function CreatePostModal({ children }: { children?: React.ReactNode }) {
  const [open, setOpen] = useState(false);
  const [content, setContent] = useState('');
  const [location, setLocation] = useState('');
  const [status, setStatus] = useState('public');
  const [mediaUrl, setMediaUrl] = useState('');
  const [showMediaInput, setShowMediaInput] = useState(false);
  const [loading, setLoading] = useState(false);
  const router = useRouter();

  const handlePost = async () => {
    if (!content.trim() && !mediaUrl.trim()) return;

    setLoading(true);
    try {
      await api.post('/posts', {
        title: content,
        location,
        status,
        media: mediaUrl ? [{ mediaUrl, mediaType: 'image' }] : [],
      });
      setOpen(false);
      setContent('');
      setLocation('');
      setStatus('public');
      setMediaUrl('');
      setShowMediaInput(false);

      // Refresh to fetch new posts
      router.refresh();
      window.location.reload();
    } catch (error) {
      console.error('Failed to create post:', error);
    } finally {
      setLoading(false);
    }
  };

  return (
    <Dialog open={open} onOpenChange={setOpen}>
      <DialogTrigger asChild>
        {children || (
          <Button variant="default" className="w-full justify-start gap-2">
            <Sparkles className="w-4 h-4" /> Create Post
          </Button>
        )}
      </DialogTrigger>
      <DialogContent className="sm:max-w-[500px]">
        <DialogHeader>
          <DialogTitle>Create new post</DialogTitle>
          <DialogDescription>
            Share what's on your mind with the world.
          </DialogDescription>
        </DialogHeader>
        <div className="grid gap-4 py-4">
          <Textarea
            placeholder="What is happening?!"
            value={content}
            onChange={(e) => setContent(e.target.value)}
            className="min-h-[120px] resize-none border-0 focus-visible:ring-0 text-lg px-0 shadow-none bg-transparent"
          />
          {showMediaInput && (
            <div className="animate-in fade-in slide-in-from-top-2 duration-200">
              <Input
                placeholder="Paste image URL here..."
                value={mediaUrl}
                onChange={(e) => setMediaUrl(e.target.value)}
                className="h-10 text-sm bg-secondary/30 rounded-md mb-2 border-primary/20"
              />
              {mediaUrl && (
                <div className="relative rounded-xl overflow-hidden max-h-[300px] border border-border">
                  <img
                    src={mediaUrl}
                    alt="Preview"
                    className="object-contain w-full h-full max-h-[300px] bg-black/5"
                    onError={(e) => { (e.target as HTMLImageElement).src = 'https://placehold.co/600x400/png?text=Invalid+Image+URL' }}
                  />
                </div>
              )}
            </div>
          )}
          <div className="border-t pt-4 flex gap-2 flex-wrap items-center">
            <Button
              variant="outline"
              size="sm"
              className={`h-8 gap-1 rounded-full ${showMediaInput ? 'bg-blue-500/10 text-blue-600 border-blue-500/30' : 'text-blue-500 hover:text-blue-600 border-blue-500/20 hover:bg-blue-500/10'}`}
              onClick={() => setShowMediaInput(!showMediaInput)}
            >
              <ImageIcon className="w-4 h-4" /> Media
            </Button>
            <div className="relative flex items-center">
              <MapPin className="w-4 h-4 absolute left-3 text-muted-foreground" />
              <Input
                placeholder="Location"
                value={location}
                onChange={(e) => setLocation(e.target.value)}
                className="h-8 pl-8 text-sm rounded-full bg-secondary/50 border-0 w-32 focus-visible:w-48 transition-all duration-300"
              />
            </div>
            <Button
              variant="outline"
              size="sm"
              className="h-8 gap-1 rounded-full ml-auto"
              onClick={() => setStatus(status === 'public' ? 'private' : 'public')}
            >
              {status === 'public' ? <Globe className="w-4 h-4" /> : <Lock className="w-4 h-4" />}
              <span className="capitalize">{status}</span>
            </Button>
          </div>
        </div>
        <DialogFooter>
          <Button
            disabled={(!content.trim() && !mediaUrl.trim()) || loading}
            onClick={handlePost}
            className="rounded-full px-8 font-bold"
          >
            {loading ? 'Posting...' : 'Post'}
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
