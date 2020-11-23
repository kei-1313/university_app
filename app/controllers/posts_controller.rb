class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy ]
  def index
    @posts = Post.page(params[:page]).per(5)
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
    if @post.save
      flash[:success] = "新しく投稿しました"
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def edit
    if @post.user != current_user
      redirect_to posts_path, alert: '不正なアクセスです'
    end
  end

  def update 
    if @post.update(post_params)
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
    #postsテーブルのtitleカラムからparams[:title]（検索した内容）が入っている投稿を抽出している
    if params[:title].present?
      @posts = Post.where('title LIKE ?', "%#{params[:title]}%")
    else
      redirect_back(fallback_location: root_path)
    end
   
   end

  private 
  def post_params
    params.require(:post).permit(:title, :body, :image)
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
