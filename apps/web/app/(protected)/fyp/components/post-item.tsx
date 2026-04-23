import React, { useState, useEffect } from 'react';
import { Heart, MessageCircle, Share2, Bookmark, MoreHorizontal } from 'lucide-react';
import { Avatar, AvatarFallback, AvatarImage } from '@workspace/ui/components/avatar';
import { Button } from '@workspace/ui/components/button';
import { CommentSection } from './comment-section';
import { useAuthStore } from '@/store/useAuthStore';
import { api } from '@/lib/api';

export const PostItem = ({ post }: { post: any }) => {
  const { user } = useAuthStore();
  const currentUserId = user?.id ? parseInt(user.id) : null;

  const [isCommentOpen, setIsCommentOpen] = useState(false);
  const [isLiked, setIsLiked] = useState(false);
  const [isFollowing, setIsFollowing] = useState(false);
  const [likeCount, setLikeCount] = useState(post.likes?.length || 0);
  const [showHeartAnimation, setShowHeartAnimation] = useState(false);

  const isOwnPost = currentUserId !== null && post.user?.id === currentUserId;

  useEffect(() => {
    if (currentUserId) {
      setIsLiked(post.likes?.some((like: any) => like.userId === currentUserId) || false);
      setIsFollowing(post.user?.followers?.some((f: any) => f.followingUserId === currentUserId) || false);
    }
  }, [currentUserId, post.likes, post.user?.followers]);
  
  const toggleComment = () => setIsCommentOpen(!isCommentOpen);

  const handleFollow = async () => {
    if (isOwnPost) return;
    const newIsFollowing = !isFollowing;
    setIsFollowing(newIsFollowing);

    try {
      await api.post(`/social/follow/${post.user?.id}`);
    } catch (error) {
      setIsFollowing(!newIsFollowing);
      console.error('Failed to toggle follow', error);
    }
  };

  const handleLike = async () => {
    // Optimistic UI update
    const newIsLiked = !isLiked;
    setIsLiked(newIsLiked);
    setLikeCount((prev: number) => newIsLiked ? prev + 1 : prev - 1);

    if (newIsLiked) {
      triggerHeartAnimation();
    }

    try {
      await api.post(`/social/like/${post.id}`);
    } catch (error) {
      // Revert if API fails
      setIsLiked(!newIsLiked);
      setLikeCount((prev: number) => newIsLiked ? prev - 1 : prev + 1);
      console.error('Failed to toggle like', error);
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

  // Safely get media URL, ignoring mediaType as requested
  const mediaUrl = post.media?.[0]?.mediaUrl || 'https://images.unsplash.com/photo-1611162617474-5b21e879e113?q=80&w=1000&auto=format&fit=crop';
  
  const renderCaption = () => {
    if (!post.title && !post.hashtags?.length) return null;
    
    const text = post.title || '';
    const parts = text.split(/(#[\w_]+)/g);
    
    const hashtagsInText = parts.filter((part: string) => part.startsWith('#')).map((part: string) => part.substring(1).toLowerCase());
    const extraHashtags = post.hashtags?.filter((ph: any) => !hashtagsInText.includes(ph.hashtag?.name?.toLowerCase())) || [];

    return (
      <p className="text-sm line-clamp-2 drop-shadow-md">
        {parts.map((part: string, i: number) => {
          if (part.startsWith('#')) {
            return <span key={i} className="text-blue-400 font-medium hover:text-blue-300 transition-colors cursor-pointer">{part}</span>;
          }
          return part;
        })}
        {extraHashtags.length > 0 && (
          <span className="text-blue-400 font-medium hover:text-blue-300 transition-colors cursor-pointer">
            {' '}{extraHashtags.map((ph: any) => `#${ph.hashtag?.name}`).join(' ')}
          </span>
        )}
      </p>
    );
  };

  return (
    <div className="h-full snap-start snap-always flex items-center justify-center relative w-full mb-4">
      <div className={`flex h-[90%] max-h-[850px] transition-all duration-300 ease-in-out ${isCommentOpen ? 'w-[750px]' : 'w-[450px]'}`}>
        
        {/* Media Container */}
        <div 
          className={`relative h-full bg-black overflow-hidden flex-shrink-0 flex items-center justify-center transition-all duration-300 ${isCommentOpen ? 'w-[400px] rounded-l-lg' : 'w-[450px] rounded-lg'} cursor-pointer`}
          onDoubleClick={handleDoubleClick}
        >
          <img src={mediaUrl} alt="Post media" className="object-cover w-full h-full select-none" />
          
          {/* Heart Animation Overlay */}
          {showHeartAnimation && (
            <div className="absolute inset-0 flex items-center justify-center pointer-events-none z-50">
              <Heart className="w-24 h-24 text-white fill-white animate-in zoom-in duration-300 drop-shadow-2xl" />
            </div>
          )}
          
          {/* Overlay Content */}
          <div className="absolute bottom-0 left-0 right-0 p-4 bg-gradient-to-t from-black/80 via-black/40 to-transparent text-white pt-12">
            <div className="flex items-center gap-2 mb-3">
              <Avatar className="w-8 h-8 border border-white/20">
                <AvatarImage src={post.user?.avatarUrl || ''} />
                <AvatarFallback className="text-black">{post.user?.userName?.charAt(0)?.toUpperCase() || 'U'}</AvatarFallback>
              </Avatar>
              <span className="font-semibold text-sm drop-shadow-md">{post.user?.userName || 'user'}</span>
              {!isOwnPost && (
                <Button 
                  onClick={handleFollow}
                  variant="outline" 
                  size="sm" 
                  className={`h-6 text-xs ml-2 rounded-full border-white hover:bg-white hover:text-black transition-colors ${isFollowing ? 'bg-white text-black' : 'bg-transparent text-white'}`}
                >
                  {isFollowing ? 'Đang theo dõi' : 'Theo dõi'}
                </Button>
              )}
            </div>
            {renderCaption()}
          </div>

          {/* Action Bar (Right side, floating inside media) */}
          <div className="absolute right-4 bottom-20 flex flex-col gap-5 items-center z-10">
            <button onClick={handleLike} className="flex flex-col items-center gap-1 group active:scale-90 transition-transform">
              <div className="p-2 rounded-full hover:bg-black/20 transition">
                <Heart className={`w-7 h-7 ${isLiked ? 'fill-red-500 text-red-500 animate-in zoom-in duration-200' : 'text-white drop-shadow-md'}`} />
              </div>
              <span className="text-white text-xs drop-shadow-md font-medium">{likeCount}</span>
            </button>

            <button onClick={toggleComment} className="flex flex-col items-center gap-1 group">
              <div className="p-2 rounded-full hover:bg-black/20 transition">
                <MessageCircle className="w-7 h-7 text-white drop-shadow-md" />
              </div>
              <span className="text-white text-xs drop-shadow-md font-medium">{post.comments?.length || 0}</span>
            </button>

            <button className="flex flex-col items-center gap-1 group">
              <div className="p-2 rounded-full hover:bg-black/20 transition">
                <Share2 className="w-7 h-7 text-white drop-shadow-md" />
              </div>
              <span className="text-white text-xs drop-shadow-md font-medium">Chia sẻ</span>
            </button>

            <button className="flex flex-col items-center gap-1 group mt-2">
              <div className="p-2 rounded-full hover:bg-black/20 transition">
                <MoreHorizontal className="w-6 h-6 text-white drop-shadow-md" />
              </div>
            </button>
          </div>
        </div>

        {/* Comment Section Panel */}
        {isCommentOpen && (
          <div className="w-[350px] h-full flex-shrink-0 animate-in slide-in-from-left-10 fade-in duration-300">
            <CommentSection post={post} onClose={() => setIsCommentOpen(false)} />
          </div>
        )}

      </div>
    </div>
  );
};
