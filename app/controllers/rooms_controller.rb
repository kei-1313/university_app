class RoomsController < ApplicationController
  before_action :authenticate_user!
  def index
    @rooms = current_user.rooms
  end

  def create 
    @room = Room.create #新しくルームを作成（カラムないから引数なし）
    @joinCurrentUser = Entry.create(user_id: current_user.id, room_id: @room.id) #entriesテーブルにuser_idとroom_idを保存している（ログインしている方）
    @joinUser = Entry.create(join_room_params) #上と同じ（ユーザー詳細側）
    #最初のメッセージの自動化
    redirect_to room_path(@room.id) #ルームにリダイレクト
  end

  def show
    @room = Room.find(params[:id])  #ルームを探す
    if Entry.where(user_id: current_user.id, room_id: @room.id).present? #ログインしている人の情報がentriesテーブルにあるか確認
        @messages = @room.messages.includes(:user).order("created_at asc") #ルーム内のメッセージを全部取得
        @message = Message.new #新しくメッセージを作る
        @entries = @room.entries #ルームに入っているユーザーを取得
    else
        redirect_back(fallback_location: root_path)
    end
  end

  private
  def join_room_params
      params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id)
  end

end
