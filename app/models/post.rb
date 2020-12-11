class Post < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :commented_users, through: :comments, source: :user
  has_many :likes, dependent: :destroy
  # 投稿が誰にいいねされているかを取得するため
  has_many :liked_users, through: :likes, source: :user
  has_one_attached :post_photo
  attachment :image 

  validates :title, presence: true, length: {maximum: 50}
  validates :body, presence: true, length: {in: 3..500}

  #通知機能
  has_many :notifications, dependent: :destroy

  #tag機能
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps

  #いいねの通知機能のメソッド
  def create_notification_like!(current_user)
    #既にいいねしているかどうか確認（連打しても通知が何回も送られないように）
    #sqlインジェクションを防ぐため？（プレイスホルダー）を使っている（置き換え可能）
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ",
                                  current_user.id, user_id, id, 'like'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'like'
      )

      #自分の投稿に対するいいねは通知済みにしておくため
      if notification.visitor_id == notification.visited_id
         notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_comment!(current_user, comment_id) #この中じゃcomment_idを指定できないから引数を用いている
    #同じ投稿にコメントしているユーザーに通知を送る。（current_userと投稿ユーザーのぞく）
    #distinctで複数回コメントしているへとの通知の一回にしている
    temp_ids = Comment.where(post_id: id).where.not("user_id=? or user_id=?", current_user.id,user_id).select(:user_id).distinct
    #取得したユーザー達へ通知を作成。（user_idのみ繰り返し取得）
    temp_ids.each do |temp_id| #temp_idにはselectされた中のひとりひとりのユーザが入っている（ログイン中のユーザと投稿者以外）
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    #投稿者へ通知を作成
    save_notification_comment!(current_user, comment_id, user_id)
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
      notification = current_user.active_notifications.new(
        post_id: id,
        comment_id: comment_id,
        visited_id: visited_id,
        action: 'comment'
      )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
  end

  #投稿検索機能
  def self.post_search(search)
     #postsテーブルのtitleカラムからparams[:search] = 引数search（検索した内容）が入っている投稿を抽出している
    if search 
      Post.where('title LIKE ?', "%#{search}%")
    else 
      Post.all
    end
  end

  #tag機能
  def save_tag(sents_tag)
    unless self.tags.nil?
    current_tag = self.tags.pluck(:tag_name) 
    end
    old_tag = current_tag - sents_tag
    new_tag = sents_tag - current_tag

    old_tag.each do |old_name|
      self.tags.delete Tag.find_by(tag_name: old_name)
    end

    new_tag.each do |new_name|
      posts_tag = Tag.find_or_create_by(tag_name: new_name)
      self.tags << posts_tag
    end
  end
      
end
