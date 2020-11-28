require 'rails_helper'

RSpec.feature "Messages", type: :feature do
  scenario "ログインユーザはDM一覧ページに行ける" do
    user = FactoryBot.create(:user)
    sign_in_as user

    within ".header-menu" do
      click_link "マイページ" 
    end

    expect(page).to have_link "DM一覧へ"
    click_link "DM一覧へ"

    expect(page).to have_content "DM一覧"
  end
end
