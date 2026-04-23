'use client';

import React, { useEffect, useState } from 'react';
import { api } from '@/lib/api';
import { PostItem } from './components/post-item';

export default function FYP() {
  const [posts, setPosts] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchPosts = async () => {
      try {
        const response = await api.get('/posts');
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
      <div className="flex h-[calc(100vh-2rem)] items-center justify-center text-zinc-400">
        No posts available right now.
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
