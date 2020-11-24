class MessagesController < ApplicationController
  before_action :set_room, only: [:create, :edit, :update, :destroy]

  def create
      if Entry.where(user_id: current_user.id, room_id: @room.id)
          @message = Message.create(message_params)
          #通知のためメッセージがどのroomにいるか取得
          @messageroomid = @message.room

              if @message.save
                #通知機能のため
                #通知する相手を取得している（相手は自分と同じroom_idを持っているからwhere.notで自分を外している）
                @roomidnotme = Entry.where(room_id: @messageroomid.id).where.not(user_id: current_user.id)
                @notificationreceiver = @roomidnotme.find_by(room_id: @messageroomid.id)
                notification = current_user.active_notifications.new(
                    room_id: @messageroomid.id,
                    message_id: @message.id,
                    visited_id: @notificationreceiver.user_id,
                    visitor_id: current_user.id,
                    action: 'message'
                )

                if notification.visitor_id == notification.visited_id
                    notification.checked = true
                end
                notification.save if notification.valid?
                #ここまで（通知機能）

                  @message = Message.new #何回もやりとりするためメッセージを保存したら新しく作る
                  gets_entries_all_messages
              end
      else
          flash[:alert] = "メッセージの送信に失敗しました"
      end
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private
  def set_room
      @room = Room.find(params[:message][:room_id])
  end

  def set_message
      @message = Message.find(params[:id])
  end

  def gets_entries_all_messages
      @messages = @room.messages.includes(:user).order("created_at asc")
      @entries = @room.entries
  end

  def message_params
      params.require(:message).permit(:user_id, :message, :room_id).merge(user_id: current_user.id)
  end
end
