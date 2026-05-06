'use client';

import React, { useEffect, useState, useRef, useCallback } from 'react';
import { api } from '@/lib/api';
import Link from 'next/link';
import { Heart, MessageCircle } from 'lucide-react';

export default function ExploreGridPage() {
  const [posts, setPosts] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [page, setPage] = useState(1);
  const [hasMore, setHasMore] = useState(true);
  const [loadingMore, setLoadingMore] = useState(false);

  const observer = useRef<IntersectionObserver | null>(null);
  const lastPostElementRef = useCallback((node: HTMLAnchorElement | null) => {
    if (loadingMore || !hasMore) return;
    if (observer.current) observer.current.disconnect();
    
    observer.current = new IntersectionObserver(entries => {
      if (entries[0]?.isIntersecting) {
        setPage(prevPage => prevPage + 1);
      }
    }, { threshold: 0.1 });
    
    if (node) observer.current.observe(node);
  }, [loadingMore, hasMore]);

  useEffect(() => {
    const fetchPosts = async () => {
      try {
        if (page === 1) setLoading(true);
        else setLoadingMore(true);
        
        const response = await api.get(`/posts?page=${page}&limit=12`);
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
          if (fetchedPosts.length < 12) setHasMore(false);
        }
      } catch (error) {
        console.error('Failed to fetch posts:', error);
      } finally {
        setLoading(false);
        setLoadingMore(false);
      }
    };
    fetchPosts();
  }, [page]);

  if (loading && page === 1) {
    return (
      <div className="flex h-[calc(100vh-2rem)] items-center justify-center text-white">
        <div className="animate-pulse flex flex-col items-center gap-4">
          <div className="w-8 h-8 border-4 border-t-white border-zinc-800 rounded-full animate-spin"></div>
          <p>Loading explore...</p>
        </div>
      </div>
    );
  }

  if (posts.length === 0) {
    return (
      <div className="flex h-[calc(100vh-2rem)] items-center justify-center text-zinc-400">
        Không có bài viết nào để khám phá.
      </div>
    );
  }

  return (
    <div className="min-h-[calc(100vh-2rem)] p-4 max-w-5xl mx-auto">
      <h1 className="text-2xl font-bold text-white mb-6">Khám phá</h1>
      <div className="grid grid-cols-3 gap-1 md:gap-4">
        {posts.map((post, index) => {
          const mediaUrl = post.media?.[0]?.mediaUrl || 'https://images.unsplash.com/photo-1611162617474-5b21e879e113?q=80&w=1000&auto=format&fit=crop';
          const isLastElement = posts.length === index + 1;
          
          return (
            <Link 
              ref={isLastElement ? lastPostElementRef : null}
              key={post.id} 
              href={`/explore/${post.id}`}
              className="relative aspect-square group bg-zinc-900 rounded-sm overflow-hidden block"
            >
              <img 
                src={mediaUrl} 
                alt="Explore post" 
                className="object-cover w-full h-full transition-transform duration-300 group-hover:scale-105"
              />
              
              {/* Hover overlay */}
              <div className="absolute inset-0 bg-black/40 opacity-0 group-hover:opacity-100 transition-opacity flex items-center justify-center gap-6">
                <div className="flex items-center gap-2 text-white font-bold">
                  <Heart className="w-6 h-6 fill-white" />
                  <span>{post.likes?.length || 0}</span>
                </div>
                <div className="flex items-center gap-2 text-white font-bold">
                  <MessageCircle className="w-6 h-6 fill-white" />
                  <span>{post.comments?.length || 0}</span>
                </div>
              </div>
            </Link>
          )
        })}
      </div>
      
      {loadingMore && (
        <div className="flex justify-center py-8">
          <div className="w-6 h-6 border-2 border-t-white border-zinc-800 rounded-full animate-spin"></div>
        </div>
      )}
    </div>
  );
}
