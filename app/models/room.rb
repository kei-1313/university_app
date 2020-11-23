class Room < ApplicationRecord
  has_many :messages
  has_many :entries
  has_many :users, through: :entries #entriesを経由してroomに入っているユーザーを取得するため

end
