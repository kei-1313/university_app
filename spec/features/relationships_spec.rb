require 'rails_helper'

RSpec.feature "Relationships", type: :feature do
  scenario "フォローする" do
    user = FactoryBot.create(:user)
    other_user = FactoryBot.create(:user)

    sign_in_as user

    within ".header-menu" do
      click_link 'ユーザ一覧'
    end

    page.all(".user-index-btn")[1].click

    click_button "フォローする"

    expect(page).to have_button "フォロー中"
  end

  scenario "フォロー解除する" do
    user = FactoryBot.create(:user)
    other_user = FactoryBot.create(:user)

    sign_in_as user

    within ".header-menu" do
      click_link 'ユーザ一覧'
    end

    page.all(".user-index-btn")[1].click

    click_button "フォローする"

    expect(page).to have_button "フォロー中"

    click_button "フォロー中"

    expect(page).to have_button "フォローする"
  end

  
end
