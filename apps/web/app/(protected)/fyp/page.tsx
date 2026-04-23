'use client';

import React, { useEffect, useState } from 'react';
import { api } from '@/lib/api';
import { PostItem } from './components/post-item';
import Link from 'next/link';
import { Button } from '@workspace/ui/components/button';
import { Users } from 'lucide-react';

export default function FYP() {
  const [posts, setPosts] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchPosts = async () => {
      try {
        const response = await api.get('/posts/following');
        // Backend's TransformInterceptor wraps the response body in { data: ... }
        // Axios also wraps the response body in response.data
        // So the array is at response.data.data
        const fetchedPosts = Array.isArray(response.data?.data) 
          ? response.data.data 
          : Array.isArray(response.data) 
            ? response.data 
            : [];
        setPosts(fetchedPosts);
      } catch (error) {
        console.error('Failed to fetch posts:', error);
      } finally {
        setLoading(false);
      }
    };
    fetchPosts();
  }, []);

  if (loading) {
    return (
      <div className="flex h-[calc(100vh-2rem)] items-center justify-center text-white">
        <div className="animate-pulse flex flex-col items-center gap-4">
          <div className="w-8 h-8 border-4 border-t-white border-zinc-800 rounded-full animate-spin"></div>
          <p>Loading your feed...</p>
        </div>
      </div>
    );
  }

  if (posts.length === 0) {
    return (
      <div className="flex h-[calc(100vh-2rem)] items-center justify-center bg-zinc-950 rounded-lg">
        <div className="max-w-md w-full p-8 text-center flex flex-col items-center animate-in fade-in zoom-in duration-500">
          <div className="w-20 h-20 bg-zinc-900 rounded-full flex items-center justify-center mb-6">
            <Users className="w-10 h-10 text-zinc-500" />
          </div>
          <h2 className="text-2xl font-bold text-white mb-3">Chưa có bài viết nào</h2>
          <p className="text-zinc-400 mb-8 leading-relaxed">
            Bạn chưa theo dõi ai hoặc những người bạn theo dõi chưa có bài viết nào. Hãy khám phá những người bạn mới để lấp đầy bảng tin của mình nhé!
          </p>
          <Link href="/explore">
            <Button className="bg-white text-black hover:bg-zinc-200 px-8 py-6 rounded-full font-bold text-base transition-all active:scale-95 shadow-lg shadow-white/5">
              Khám phá ngay
            </Button>
          </Link>
        </div>
      </div>
    );
  }

  return (
    <div className="h-[calc(100vh-2rem)] overflow-y-scroll snap-y snap-mandatory bg-zinc-950 rounded-lg pb-4 [&::-webkit-scrollbar]:hidden [-ms-overflow-style:none] [scrollbar-width:none]">
      {posts.map((post) => (
        <PostItem key={post.id} post={post} />
      ))}
    </div>
  );
}
