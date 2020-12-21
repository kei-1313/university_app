class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy ]
  def index
    @posts = Post.page(params[:page]).per(10)
    @tags = Tag.all
    @rankings = Post.unscoped.likes_ranking
  end

  def show
    @comments = @post.comments
    @comment = Comment.new
    @like = Like.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    tag_list = params[:post][:tag_name].split(",")
    if @post.save
      #タグ機能
      @post.save_tag(tag_list)
      #ここまで

      flash[:success] = "新しく投稿しました"
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def edit
    @tag_list = @post.tags.pluck(:tag_name).join(",")
    if @post.user != current_user
      redirect_to posts_path, alert: '不正なアクセスです'
    end
  end

  def update 
    tag_list = params[:post][:tag_name].split(",")
    if @post.update(post_params)
      #タグ機能
      @post.save_tag(tag_list)
      #ここまで

      flash[:success] = '投稿を編集しました'
      redirect_to post_path(@post)
    else
      render :edit 
    end
  end

  def destroy
    @post.destroy
    flash[:success] = '投稿を削除しました'
    redirect_to posts_path
  end

   #検索機能（あいまい検索）
   def search 
    @posts = Post.post_search(params[:search])
   end

  private 
  def post_params
    params.require(:post).permit(:title, :body, :post_photo)
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
