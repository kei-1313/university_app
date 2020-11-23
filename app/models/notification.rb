class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) } #defaultで通知を新しい順に取得できるようにしている
  belongs_to :visitor, class_name: "User", optional: true  #optionalでnilの保存を許可している
  belongs_to :visited, class_name: "User", optional: true
  belongs_to :post, optional: true
  belongs_to :comment, optional: true

  validates :visitor_id, presence: true
  validates :visited_id, presence: true
  ACTION_VALUES = ["like", "follow", "comment"]
  validates :action,  presence: true, inclusion: {in:ACTION_VALUES} #inclusionで保存できる値を制限している
  validates :checked, inclusion: {in: [true,false]}
end
