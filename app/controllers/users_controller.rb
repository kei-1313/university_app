class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :update, :followings, :followers ]
  def index
    @users = User.all
  end

  def show
    if user_signed_in? #ログインしているかどうか
      @currentUserEntry = Entry.where(user_id: current_user.id) #既にルームに参加しているかどうか確認するためentriesテーブルからuser_idがログインしているユーザーのidと一致するものを全て取得している
      @userEntry = Entry.where(user_id: @user.id) #ユーザー詳細のユーザーが既にルームに参加している確認（上と同じ）
      unless @user.id == current_user.id #ユーザー詳細のページのユーザーがログインしているユーザーでないことを確認
        @currentUserEntry.each do |cu| #上で取得したものを一つずつ取り出しcuに格納
          @userEntry.each do |u|  #上と同じ
            if cu.room_id == u.room_id #取り出したもののroom_idが同じであるか確認（既に部屋に入っているか）
              @haveRoom = true  #入っている場合 trueを@haveRoomに格納（既にルームが存在するという意味）
              @roomId = cu.room_id  #
            end
          end
        end
        unless @haveRoom  #ルームに入っていない場合 
          @room = Room.new #roomを新しく作る
          @entry = Entry.new #@roomと@entryをformで送るため
        end
      end
    end
  end

  def update
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  #フォロー機能
  def followings
    @users = @user.followings #@userにはどのユーザーであるかの情報が格納されていてuserモデルで定義したfollowingsでフォローした人を取得している
    render 'show_followings'
  end

  def followers
    @users = @user.followers #上の逆フォロワーバージョン
    render 'show_followers'
  end


  private 
  def user_params
    params.require(:user).permit(:username, :student_id, :email, :password, :profile_image, :profile)
  end

  def set_user
    @user =User.find(params[:id])
  end
end
