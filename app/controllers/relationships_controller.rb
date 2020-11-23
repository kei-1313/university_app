class RelationshipsController < ApplicationController
  before_action :set_relationship_user
  def create
    current_user.follow(@user) #ログインしているユーザーが@userをフォローしている
    #通知機能追加
    @user.create_notification_follow!(current_user)
    respond_to do |format|
      format.html { redirect_to @user, flash: {success: 'フォローしました'} } #クライアント側でjsが無効になっていた場合これを返す
      format.js #form_withからjs形式で飛んできてrelationshipsのcreate.js.erbに飛ぶ
    end
  end

  def destroy
    current_user.unfollow(@user) #ログインしているユーザーが@userをフォロー解除している
    respond_to do |format|
      format.html { redirect_to @user, flash: {success: 'フォロー解除しました'} }
      format.js
    end
  end

  private

  def set_relationship_user
    @user = User.find(params[:relationship][:following_id])
  end
end
