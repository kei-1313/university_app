class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.post_id = @post.id
    if @comment.save
      flash[:success] = 'コメントをしました'
      #通知機能
      @post = @comment.post
      @post.create_notification_comment!(current_user, @comment.id)

      redirect_to post_path(@comment.post_id)
    else
      render 'posts/show'
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id], post_id: params[:post_id])
    if @comment.destroy
      flash[:success] = 'コメントを削除しました'
      redirect_to post_path(@comment.post_id)
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end
