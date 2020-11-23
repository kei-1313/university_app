class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, length: {maximum: 18}       
  VALID_SYUDENT_ID_REGEX = /\A[A-Z0-9]+\z/i
  validates :student_id, presence: true, uniqueness: { case_sensitive: false }, length: {in: 7..8}, format: { with: VALID_SYUDENT_ID_REGEX,
    message: "は半角7~8文字で英大文字と数字で入力して下さい"}   
  validates :email,  uniqueness: {case_sensitive: false, message: "は既に使用されています"}     

  attachment :profile_image   
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :commented_posts, through: :comments, source: :post
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  #フォロー機能
  has_many :following_relationships,foreign_key: "follower_id", class_name: "Relationship",  dependent: :destroy
  has_many :followings, through: :following_relationships #架空のfollowingsモデルにアクセスしてフォローしているユーザーのidを取得できるようになる（relationshipsテーブルを中間テーブルとして使っている）
  has_many :follower_relationships,foreign_key: "following_id",class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships #フォローされているユーザーのidを取得できるようになる

  #DM機能
  has_many :messages
  has_many :entries
  has_many :rooms, through: :entries  #entriesテーブルを経由してroomの情報を取得するため

  #通知機能（notificationsテーブルに関連づけしている）
  has_many :active_notifications, foreign_key:"visitor_id", class_name: "Notification", dependent: :destroy #通知をした側
  has_many :passive_notifications, foreign_key:"visited_id", class_name: "Notification", dependent: :destroy #通知をされた側


  def posts
    return Post.where(user_id: self.id)
  end

  # ユーザーがどの投稿にいいねしているか取得するため
  def alread_liked?(post)
    self.likes.exists?(post_id: post.id)
  end

  #フォロー機能
  #すでにフォロー済みであればture返す
  def following?(other_user)
    self.followings.include?(other_user)
  end

  #ユーザーをフォローする(selfにはuserのインスタンスが入る)
  def follow(other_user)
    self.following_relationships.create(following_id: other_user.id)
  end

  #ユーザーのフォローを解除する
  def unfollow(other_user)
    self.following_relationships.find_by(following_id: other_user.id).destroy
  end

  #通知機能
  def create_notification_follow!(current_user)
    #すでに通知が作成されているか確認
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end
end
