'use client';

import React, { useEffect, useState, useRef, useCallback } from 'react';
import { api } from '@/lib/api';
import { PostItem } from './components/post-item';

export default function FYP() {
  const [posts, setPosts] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [page, setPage] = useState(1);
  const [hasMore, setHasMore] = useState(true);
  const [loadingMore, setLoadingMore] = useState(false);

  const observer = useRef<IntersectionObserver | null>(null);
  const lastPostElementRef = useCallback((node: HTMLDivElement | null) => {
    if (loadingMore || !hasMore) return;
    if (observer.current) observer.current.disconnect();
    
    observer.current = new IntersectionObserver(entries => {
      if (entries[0]?.isIntersecting) {
        setPage(prevPage => prevPage + 1);
      }
    }, { threshold: 0.1 });
    
    if (node) observer.current.observe(node);
  }, [loadingMore, hasMore]);

  const fetchPosts = async (pageNum: number) => {
    try {
      if (pageNum === 1) setLoading(true);
      else setLoadingMore(true);

      const response = await api.get(`/posts?page=${pageNum}&limit=5`);
      const fetchedPosts = Array.isArray(response.data?.data) 
        ? response.data.data 
        : Array.isArray(response.data) 
          ? response.data 
          : [];
      
      if (fetchedPosts.length === 0) {
        setHasMore(false);
      } else {
        setPosts(prev => {
          const newPosts = (fetchedPosts as any[]).filter((p: any) => !prev.some((existing: any) => existing.id === p.id));
          return [...prev, ...newPosts];
        });
        if (fetchedPosts.length < 5) setHasMore(false);
      }
    } catch (error) {
      console.error('Failed to fetch posts:', error);
    } finally {
      setLoading(false);
      setLoadingMore(false);
    }
  };

  useEffect(() => {
    fetchPosts(page);
  }, [page]);

  if (loading && page === 1) {
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
      {posts.map((post, index) => {
        if (posts.length === index + 1) {
          return (
            <div ref={lastPostElementRef} key={post.id}>
              <PostItem post={post} />
            </div>
          );
        } else {
          return <PostItem key={post.id} post={post} />;
        }
      })}
      
      {loadingMore && (
        <div className="flex justify-center py-4">
          <div className="w-6 h-6 border-2 border-t-white border-zinc-800 rounded-full animate-spin"></div>
        </div>
      )}
      {!hasMore && posts.length > 0 && (
        <div className="text-center py-6 text-zinc-500 text-sm">
          You have seen all posts!
        </div>
      )}
    </div>
  );
}
