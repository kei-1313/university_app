class AddIndexNotificationsRoomId < ActiveRecord::Migration[6.0]
  def change
    add_index :notifications, :room_id
    add_index :notifications, :message_id
  end
end
