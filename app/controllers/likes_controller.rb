class LikesController < ApplicationController
  def create
    @like = current_user.likes.create(post_id: params[:post_id])
    #通知機能追加
    @post = Post.find(params[:post_id])  #どの投稿にいいねしたか取得
    @post.create_notification_like!(current_user)
    redirect_back(fallback_location: root_path) #直前のページに飛ばしている（エラーが出るとroot_pathに飛ぶようになっている）
  end

  def destroy
    @like = Like.find_by(post_id: params[:post_id], user_id: current_user.id)
    @like.destroy
    redirect_back(fallback_location: root_path)
  end
end
