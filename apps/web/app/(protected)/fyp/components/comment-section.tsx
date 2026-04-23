import React, { useState } from 'react';
import { Avatar, AvatarFallback, AvatarImage } from '@workspace/ui/components/avatar';
import { Button } from '@workspace/ui/components/button';
import { Input } from '@workspace/ui/components/input';
import { X, Heart, Send } from 'lucide-react';

export const CommentSection = ({ post, onClose }: { post: any, onClose: () => void }) => {
  const [newComment, setNewComment] = useState('');

  const comments = post.comments || [];

  return (
    <div className="flex flex-col h-full bg-zinc-950 text-white rounded-r-lg border-l border-zinc-800">
      {/* Header */}
      <div className="flex items-center justify-between p-4 border-b border-zinc-800">
        <h3 className="font-semibold text-lg">Bình luận</h3>
        <Button variant="ghost" size="icon" onClick={onClose} className="h-8 w-8 text-zinc-400 hover:text-white hover:bg-zinc-800">
          <X className="h-5 w-5" />
        </Button>
      </div>

      {/* Post Caption (as first comment) */}
      <div className="p-4 border-b border-zinc-800 flex gap-3">
        <Avatar className="w-8 h-8 flex-shrink-0">
          <AvatarImage src={post.user?.avatarUrl || ''} />
          <AvatarFallback>{post.user?.userName?.charAt(0)?.toUpperCase() || 'U'}</AvatarFallback>
        </Avatar>
        <div>
          <p className="text-sm">
            <span className="font-semibold mr-2">{post.user?.userName || 'user'}</span>
            {post.title}
          </p>
          <p className="text-xs text-zinc-500 mt-1">
            {new Date(post.createdAt).toLocaleDateString()}
          </p>
        </div>
      </div>

      {/* Comments List */}
      <div className="flex-1 overflow-y-auto p-4 space-y-4 [&::-webkit-scrollbar]:hidden [-ms-overflow-style:none] [scrollbar-width:none]">
        {comments.length === 0 ? (
          <div className="h-full flex items-center justify-center text-zinc-500 text-sm">
            Chưa có bình luận nào. Hãy là người đầu tiên bình luận!
          </div>
        ) : (
          comments.map((comment: any) => (
            <div key={comment.id} className="flex gap-3 group">
              <Avatar className="w-8 h-8 flex-shrink-0">
                <AvatarImage src={comment.user?.avatarUrl || ''} />
                <AvatarFallback>{comment.user?.userName?.charAt(0)?.toUpperCase() || 'U'}</AvatarFallback>
              </Avatar>
              <div className="flex-1">
                <p className="text-sm">
                  <span className="font-semibold mr-2">{comment.user?.userName || 'user'}</span>
                  {comment.content}
                </p>
                <div className="flex items-center gap-4 mt-1 text-xs text-zinc-500">
                  <span>{new Date(comment.createdAt).toLocaleDateString()}</span>
                  <button className="font-semibold hover:text-zinc-300">Trả lời</button>
                </div>
              </div>
              <button className="text-zinc-500 hover:text-red-500 self-center opacity-0 group-hover:opacity-100 transition-opacity">
                <Heart className="w-4 h-4" />
              </button>
            </div>
          ))
        )}
      </div>

      {/* Comment Input Box */}
      <div className="p-4 border-t border-zinc-800 flex gap-3 items-center">
        <Avatar className="w-8 h-8 flex-shrink-0">
          <AvatarFallback>Me</AvatarFallback>
        </Avatar>
        <div className="flex-1 relative">
          <Input 
            value={newComment}
            onChange={(e) => setNewComment(e.target.value)}
            placeholder="Thêm bình luận..." 
            className="w-full bg-zinc-900 border-none text-sm placeholder:text-zinc-500 focus-visible:ring-1 focus-visible:ring-zinc-700 rounded-full pr-10"
          />
          {newComment.trim().length > 0 && (
            <button className="absolute right-3 top-1/2 -translate-y-1/2 text-blue-500 hover:text-blue-400 font-semibold text-sm">
              Đăng
            </button>
          )}
        </div>
      </div>
    </div>
  );
};
