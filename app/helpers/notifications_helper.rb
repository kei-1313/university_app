module NotificationsHelper
  def notification_form(notification)
    #通知を送ってきたユーザーを取得
    @visitor = notification.visitor
    # notification.actionがfollowかlikeかcommentかで処理を変える
    case notification.action
    when 'follow'
      #aタグで通知を作成したユーザーshowのリンクを作成
      tag.a(notification.visitor.username, href: user_path(@visitor)) + 'さんがあなたをフォローしました'
    when 'like'
      tag.a(notification.visitor.username, href: user_path(@visitor)) + 'さんが' + tag.a('あなたの投稿', href: post_path(notification.post_id)) + 'にいいねしました'
    when 'comment' 
      if notification.post.user_id == notification.visited.id
        tag.a(@visitor.username, href: user_path(@visitor)) + 'さんが' + tag.a("あなたの投稿", href: post_path(notification.post_id)) + 'にコメントしました'
      else
        tag.a(@visitor.username, href: user_path(@visitor)) + 'さんが' + tag.a("#{notification.post.user.username}さんの投稿", href: post_path(notification.post_id)) + 'にコメントしました'
      end
    when 'message' then
      tag.a(notification.visitor.username, href: user_path(@visitor)) + 'さんからメッセージが届きました'
    end  
  end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end
