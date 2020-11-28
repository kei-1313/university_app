module RoomsHelper
  def most_new_message(room)
    message = room.messages.order(updated_at: :desc).limit(1)

    message = message[0]

    if message.present?
      tag.p "#{message.message}", class: 'dm-index-message'
    else
      tag.p "まだメッセージはありません", class: 'dm-index-message'
    end
  end

  def most_new_message_time(room)
    message = room.messages.order(updated_at: :desc).limit(1)

    message = message[0]

    if message.present?
      tag.p "#{time_ago_in_words(message.created_at)}前", class: 'dm-index-message-time'
    end
  end

  def not_me_user(room)
    entry = room.entries.where.not(user_id: current_user.id)

    name = entry[0].user.username
    
    tag.p "#{name}", class: 'dm-index-username'
   
  end

  def not_me_user_profile_img(room)
    entry = room.entries.where.not(user_id: current_user.id)

    profileimg = entry[0].user

    attachment_image_tag profileimg, :profile_image, fallback: "no-image.png", class: 'dm-index-img'
  end
end
