class TagsController < ApplicationController
  before_action :authenticate_user!
  def show
    @tag = Tag.find(params[:id])
    @rankings = Post.unscoped.likes_ranking
    @tags = Tag.all
    @histories = current_user.browsing_histories.order(id: "DESC").limit(5)
  end
end
