class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :content, presence: true, length: {maximum: 500}

  #通知機能
  has_many :notifications, dependent: :destroy

  # 日付の取得
  def set_date
    created_at.strftime("%Y年%m月%d日%H時%M分")
  end
end
