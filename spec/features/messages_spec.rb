require 'rails_helper'

RSpec.feature "Messages", type: :feature do
  # scenario "メッセージを送る", js: true do
  #   user = FactoryBot.create(:user)
  #   other_user = FactoryBot.create(:user)
  #   sign_in_as user

  #   expect {
  #     within ".header-menu" do
  #       click_link "ユーザー一覧"
  #     end
  
  #     page.all(".user-index-btn")[1].click
  
  #     click_button "DMを始める"
  
  #     expect(page).to have_content "メッセージはまだありません"
  
  #     find(".chat-text-field").set("こんにちは")
  #     click_button "送信"
  #     expect(page).to have_content "こんにちは"
  #   }.to change(user.messages, :count).by(1)
  # end
end
