class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy ]
  before_action :set_tag, only: [:index, :search,]
  before_action :set_ranking, only: [:index, :search,]
  before_action :set_history, only: [:index, :search,]
  def index
    @posts = Post.page(params[:page]).per(10)
    @current_time= Time.current
  end

  def show
    @comments = @post.comments
    @comment = Comment.new
    @like = Like.new

    new_history = @post.browsing_histories.new
    new_history.user_id = current_user.id

    if current_user.browsing_histories.exists?(post_id: "#{params[:id]}")
      old_history = current_user.browsing_histories.find_by(post_id: "#{params[:id]}")
      old_history.destroy
    end

    unless new_history.user_id == @post.user_id
      new_history.save
    end
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

  def set_tag
    @tags = Tag.all
  end

  def set_ranking
    @rankings = Post.unscoped.likes_ranking
  end

  def set_history
    @histories = current_user.browsing_histories.order(id: "DESC").limit(5)
  end

end
