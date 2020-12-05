class LikesController < ApplicationController
  def create
    @like = current_user.likes.create(post_id: params[:post_id])
    #通知機能追加
    @post = Post.find(params[:post_id])  #どの投稿にいいねしたか取得
    @post.create_notification_like!(current_user)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @like = Like.find_by(post_id: params[:post_id], user_id: current_user.id)
    @like.destroy
  end

end
