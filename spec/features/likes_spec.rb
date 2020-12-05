# require 'rails_helper'

# RSpec.feature "Likes", type: :feature do
#   scenario 'いいねできるか' do
#     user = FactoryBot.create(:user)
#     other_user = FactoryBot.create(:user, :with_posts)
#     sign_in_as user

#     expect {
#       within ".header-menu" do
#         click_link "投稿一覧" 
#       end
#       first(".link_to_allpost").click
  
#       find(".like_btn").click
#     }.to change(other_user.posts[0].likes, :count).by(1)
#   end

#   scenario 'いいね解除できるか' do
#     user = FactoryBot.create(:user)
#     other_user = FactoryBot.create(:user, :with_posts)
#     sign_in_as user

#     within ".header-menu" do
#       click_link "投稿一覧" 
#     end
#     first(".link_to_allpost").click

#     find(".like_btn").click
    
#     expect {
#       find(".unlike_btn").click
#     }.to change(other_user.posts[0].likes, :count).by(-1)
#   end
# end
