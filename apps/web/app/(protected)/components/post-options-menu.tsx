'use client';
import React, { useState } from 'react';
import { MoreHorizontal } from 'lucide-react';

interface PostOptionsMenuProps {
  isOwner: boolean;
  onDelete: () => void;
  onEdit?: () => void;
  className?: string;
  iconClassName?: string;
}

export function PostOptionsMenu({ isOwner, onDelete, onEdit, className, iconClassName }: PostOptionsMenuProps) {
  const [isMenuOpen, setIsMenuOpen] = useState(false);

  const handleDelete = (e: React.MouseEvent) => {
    e.preventDefault();
    e.stopPropagation();
    setIsMenuOpen(false);
    onDelete();
  };

  const handleClose = (e: React.MouseEvent) => {
    e.preventDefault();
    e.stopPropagation();
    setIsMenuOpen(false);
  };

  const handleStopPropagation = (e: React.MouseEvent) => {
    e.preventDefault();
    e.stopPropagation();
  };

  return (
    <>
      <button 
        onClick={(e) => {
          e.preventDefault();
          e.stopPropagation();
          setIsMenuOpen(true);
        }} 
        className={className}
      >
        <MoreHorizontal className={iconClassName || "w-6 h-6"} />
      </button>

      {isMenuOpen && (
        <div className="fixed inset-0 z-[100] flex items-center justify-center bg-black/60 backdrop-blur-sm" onClick={handleClose}>
          <div className="bg-[#262626] w-[400px] rounded-xl flex flex-col text-sm font-semibold overflow-hidden shadow-2xl animate-in zoom-in-95 duration-200" onClick={handleStopPropagation}>
            {isOwner ? (
              <>
                <button onClick={handleDelete} className="py-3.5 border-b border-white/10 text-red-500 hover:bg-white/5 transition w-full text-center">Xóa</button>
                <button 
                  onClick={(e) => {
                    e.preventDefault();
                    e.stopPropagation();
                    setIsMenuOpen(false);
                    onEdit?.();
                  }} 
                  className="py-3.5 border-b border-white/10 text-white hover:bg-white/5 transition w-full text-center"
                >
                  Chỉnh sửa
                </button>
                <button className="py-3.5 border-b border-white/10 text-white hover:bg-white/5 transition w-full text-center">Ẩn số lượt thích với những người khác</button>
                <button className="py-3.5 border-b border-white/10 text-white hover:bg-white/5 transition w-full text-center">Tắt tính năng bình luận</button>
              </>
            ) : (
              <button className="py-3.5 border-b border-white/10 text-red-500 hover:bg-white/5 transition w-full text-center">Báo cáo</button>
            )}
            <button className="py-3.5 border-b border-white/10 text-white hover:bg-white/5 transition w-full text-center">Đi đến bài viết</button>
            <button className="py-3.5 border-b border-white/10 text-white hover:bg-white/5 transition w-full text-center">Chia sẻ lên...</button>
            <button className="py-3.5 border-b border-white/10 text-white hover:bg-white/5 transition w-full text-center">Sao chép liên kết</button>
            <button className="py-3.5 border-b border-white/10 text-white hover:bg-white/5 transition w-full text-center">Nhúng</button>
            <button className="py-3.5 border-b border-white/10 text-white hover:bg-white/5 transition w-full text-center">Giới thiệu về tài khoản này</button>
            <button onClick={handleClose} className="py-3.5 text-white hover:bg-white/5 transition w-full text-center">Hủy</button>
          </div>
        </div>
      )}
    </>
  );
}
