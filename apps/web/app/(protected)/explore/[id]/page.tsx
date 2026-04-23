'use client';

import React, { useEffect, useState, use } from 'react';
import { api } from '@/lib/api';
import { Avatar, AvatarFallback, AvatarImage } from '@workspace/ui/components/avatar';
import { Input } from '@workspace/ui/components/input';
import { Heart, MessageCircle, Share2, Bookmark, MoreHorizontal } from 'lucide-react';
import { useAuthStore } from '@/store/useAuthStore';

export default function ExplorePostPage({ params }: { params: Promise<{ id: string }> }) {
  const resolvedParams = use(params);
  const postId = resolvedParams.id;
  
  const { user } = useAuthStore();
  const currentUserId = user?.id ? parseInt(user.id) : null;
  
  const [post, setPost] = useState<any>(null);
  const [loading, setLoading] = useState(true);
  const [activeImageIndex, setActiveImageIndex] = useState(0);
  const [isLiked, setIsLiked] = useState(false);
  const [likeCount, setLikeCount] = useState(0);
  const [showHeartAnimation, setShowHeartAnimation] = useState(false);
  const [newComment, setNewComment] = useState('');

  useEffect(() => {
    const fetchPost = async () => {
      try {
        const response = await api.get(`/posts/${postId}`);
        const data = response.data?.data || response.data;
        setPost(data);
        if (currentUserId) {
          setIsLiked(data.likes?.some((like: any) => like.userId === currentUserId) || false);
        }
        setLikeCount(data.likes?.length || 0);
      } catch (error) {
        console.error('Failed to fetch post:', error);
      } finally {
        setLoading(false);
      }
    };
    if (postId) {
      fetchPost();
    }
  }, [postId, currentUserId]);

  if (loading) {
    return (
      <div className="flex h-[calc(100vh-2rem)] items-center justify-center text-white">
        <div className="animate-pulse flex flex-col items-center gap-4">
          <div className="w-8 h-8 border-4 border-t-white border-zinc-800 rounded-full animate-spin"></div>
          <p>Loading post...</p>
        </div>
      </div>
    );
  }

  if (!post) {
    return <div className="flex h-[calc(100vh-2rem)] items-center justify-center text-zinc-400">Post not found</div>;
  }

  const media = post.media?.length > 0 ? post.media : [{ id: 0, mediaUrl: 'https://images.unsplash.com/photo-1611162617474-5b21e879e113?q=80&w=1000&auto=format&fit=crop' }];
  const comments = post.comments || [];

  const handleScroll = (e: React.UIEvent<HTMLDivElement>) => {
    const container = e.currentTarget;
    const scrollPosition = container.scrollLeft;
    const width = container.clientWidth;
    const newIndex = Math.round(scrollPosition / width);
    if (newIndex !== activeImageIndex) {
      setActiveImageIndex(newIndex);
    }
  };

  const handleLike = async () => {
    const newIsLiked = !isLiked;
    setIsLiked(newIsLiked);
    setLikeCount((prev: number) => newIsLiked ? prev + 1 : prev - 1);

    if (newIsLiked) {
      triggerHeartAnimation();
    }

    try {
      await api.post(`/social/like/${postId}`);
    } catch (error) {
      setIsLiked(!newIsLiked);
      setLikeCount((prev: number) => newIsLiked ? prev - 1 : prev + 1);
    }
  };

  const handleDoubleClick = () => {
    if (!isLiked) {
      handleLike();
    } else {
      triggerHeartAnimation();
    }
  };

  const triggerHeartAnimation = () => {
    setShowHeartAnimation(true);
    setTimeout(() => setShowHeartAnimation(false), 1000);
  };

  return (
    <div className="min-h-[calc(100vh-2rem)] flex items-center justify-center py-4">
      {/* Main Container - Instagram Web Style */}
      <div className="flex flex-col md:flex-row w-full max-w-[1000px] h-[85vh] min-h-[500px] bg-black border border-zinc-800 rounded-md overflow-hidden shadow-2xl">
        
        {/* Left Side - Image Slider */}
        <div className="relative w-full md:w-[60%] h-[50vh] md:h-full bg-zinc-950 flex flex-col items-center justify-center border-b md:border-b-0 md:border-r border-zinc-800 group">
          <div 
            className="flex w-full h-full overflow-x-auto snap-x snap-mandatory [&::-webkit-scrollbar]:hidden [-ms-overflow-style:none] [scrollbar-width:none] scroll-smooth select-none cursor-pointer"
            onScroll={handleScroll}
            onDoubleClick={handleDoubleClick}
          >
            {media.map((m: any) => (
              <div key={m.id} className="w-full h-full flex-shrink-0 snap-center flex items-center justify-center bg-black relative">
                <img src={m.mediaUrl} alt="Post media" className="object-contain w-full h-full pointer-events-none" />
              </div>
            ))}
          </div>

          {/* Heart Animation Overlay */}
          {showHeartAnimation && (
            <div className="absolute inset-0 flex items-center justify-center pointer-events-none z-50">
              <Heart className="w-32 h-32 text-white fill-white animate-in zoom-in duration-300 drop-shadow-2xl" />
            </div>
          )}

          {/* Image Indicators */}
          {media.length > 1 && (
            <div className="absolute bottom-4 flex gap-1.5 justify-center w-full">
              {media.map((_: any, idx: number) => (
                <div 
                  key={idx} 
                  className={`w-1.5 h-1.5 rounded-full transition-all duration-300 ${idx === activeImageIndex ? 'bg-white scale-125' : 'bg-white/50'}`}
                />
              ))}
            </div>
          )}
        </div>

        {/* Right Side - Post Info & Comments */}
        <div className="w-full md:w-[40%] flex flex-col bg-black h-full text-white">
          
          {/* Header */}
          <div className="flex items-center justify-between p-4 border-b border-zinc-800 flex-shrink-0">
            <div className="flex items-center gap-3">
              <Avatar className="w-8 h-8">
                <AvatarImage src={post.user?.avatarUrl || ''} />
                <AvatarFallback className="text-black">{post.user?.userName?.charAt(0)?.toUpperCase() || 'U'}</AvatarFallback>
              </Avatar>
              <span className="font-semibold text-sm hover:text-zinc-300 cursor-pointer transition">{post.user?.userName || 'user'}</span>
              <span className="text-zinc-500 text-xs font-medium">• Theo dõi</span>
            </div>
            <MoreHorizontal className="w-5 h-5 cursor-pointer hover:text-zinc-400 transition" />
          </div>

          {/* Comments Area (Scrollable) */}
          <div className="flex-1 overflow-y-auto p-4 space-y-5 [&::-webkit-scrollbar]:hidden [-ms-overflow-style:none] [scrollbar-width:none]">
            
            {/* Caption */}
            {post.title && (
              <div className="flex gap-3 mb-6">
                <Avatar className="w-8 h-8 flex-shrink-0">
                  <AvatarImage src={post.user?.avatarUrl || ''} />
                  <AvatarFallback className="text-black">{post.user?.userName?.charAt(0)?.toUpperCase() || 'U'}</AvatarFallback>
                </Avatar>
                <div>
                  <p className="text-sm">
                    <span className="font-semibold mr-2 hover:text-zinc-300 cursor-pointer">{post.user?.userName || 'user'}</span>
                    <span className="text-zinc-200">{post.title}</span>
                  </p>
                </div>
              </div>
            )}

            {/* Comments List */}
            {comments.map((comment: any) => (
              <div key={comment.id} className="flex gap-3 group">
                <Avatar className="w-8 h-8 flex-shrink-0">
                  <AvatarImage src={comment.user?.avatarUrl || ''} />
                  <AvatarFallback className="text-black">{comment.user?.userName?.charAt(0)?.toUpperCase() || 'U'}</AvatarFallback>
                </Avatar>
                <div className="flex-1">
                  <p className="text-sm">
                    <span className="font-semibold mr-2 hover:text-zinc-300 cursor-pointer">{comment.user?.userName || 'user'}</span>
                    <span className="text-zinc-200">{comment.content}</span>
                  </p>
                  <div className="flex items-center gap-4 mt-1 text-xs text-zinc-500 font-medium">
                    <span>{new Date(comment.createdAt).toLocaleDateString()}</span>
                    <button className="hover:text-zinc-300 transition">Trả lời</button>
                  </div>
                </div>
                <button className="text-zinc-500 hover:text-red-500 self-center opacity-0 group-hover:opacity-100 transition-opacity p-2">
                  <Heart className="w-3 h-3" />
                </button>
              </div>
            ))}
            
            {comments.length === 0 && !post.title && (
              <div className="h-full flex items-center justify-center text-zinc-500 text-sm">
                Chưa có bình luận nào.
              </div>
            )}
          </div>

          {/* Action Bar Footer */}
          <div className="border-t border-zinc-800 p-4 pb-2 flex-shrink-0 bg-black">
            <div className="flex justify-between items-center mb-3">
              <div className="flex gap-4">
                <button onClick={handleLike} className="hover:opacity-70 transition active:scale-90">
                  <Heart className={`w-6 h-6 ${isLiked ? 'fill-red-500 text-red-500 animate-in zoom-in duration-200' : 'text-white'}`} />
                </button>
                <button className="hover:opacity-70 transition active:scale-95">
                  <MessageCircle className="w-6 h-6 text-white" />
                </button>
                <button className="hover:opacity-70 transition active:scale-95">
                  <Share2 className="w-6 h-6 text-white" />
                </button>
              </div>
              <button className="hover:opacity-70 transition active:scale-95">
                <Bookmark className="w-6 h-6 text-white" />
              </button>
            </div>
            <p className="font-semibold text-sm mb-1">{likeCount} lượt thích</p>
            <p className="text-[10px] text-zinc-500 uppercase tracking-wide">
              {new Date(post.createdAt).toLocaleDateString()}
            </p>
          </div>

          {/* Add Comment Input */}
          <div className="p-4 py-3 border-t border-zinc-800 flex items-center relative flex-shrink-0 bg-black">
            <Input 
              value={newComment}
              onChange={(e) => setNewComment(e.target.value)}
              placeholder="Thêm bình luận..." 
              className="w-full bg-transparent border-none text-sm placeholder:text-zinc-500 focus-visible:ring-0 px-0 h-auto shadow-none pr-12 focus:outline-none"
            />
            {newComment.trim().length > 0 && (
              <button className="absolute right-4 text-blue-500 hover:text-white font-semibold text-sm transition">
                Đăng
              </button>
            )}
          </div>

        </div>
      </div>
    </div>
  );
}
