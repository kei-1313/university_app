require 'rails_helper'

RSpec.feature "Notifications", type: :feature do
  scenario "フォローされた場合の通知" do
    user = FactoryBot.create(:user)
    other_user = FactoryBot.create(:user)
    sign_in_as other_user

    within ".header-menu" do
      click_link "ユーザー一覧"
    end

    first(".user-index-btn").click


    click_button "フォローする"
    expect(page).to have_button "フォロー中"

    within ".header-menu" do
      click_link "ログアウト"
    end
    expect(page).to have_content "ログアウトしました。"
    
    sign_in_as user

    within ".header-menu" do
      click_link "通知"
    end

    expect(page).to have_content "通知"
    expect(page).to have_content "#{other_user.username}さんがあなたをフォローしました"
  end

  scenario "コメントされた場合の通知" do
    user = FactoryBot.create(:user, :with_posts)
    other_user = FactoryBot.create(:user)
    sign_in_as other_user

    within ".header-menu" do
      click_link "投稿一覧"
    end

    first(".link_to_allpost").click

    fill_in "comment_feild", with: "通知します"
    click_button "コメントを投稿する"
    expect(page).to have_content "通知します"

    within ".header-menu" do
      click_link "ログアウト"
    end
    expect(page).to have_content "ログアウトしました。"
    
    sign_in_as user

    within ".header-menu" do
      click_link "通知"
    end

    expect(page).to have_content "通知"
    expect(page).to have_content "#{other_user.username}さんがあなたの投稿にコメントしました"
  end

  scenario "いいねされた場合の通知" do
    user = FactoryBot.create(:user, :with_posts)
    other_user = FactoryBot.create(:user)
    sign_in_as other_user

    within ".header-menu" do
      click_link "投稿一覧"
    end

    first(".link_to_allpost").click

    find(".like_btn").click

    within ".header-menu" do
      click_link "ログアウト"
    end
    expect(page).to have_content "ログアウトしました。"
    
    sign_in_as user

    within ".header-menu" do
      click_link "通知"
    end

    expect(page).to have_content "通知"
    expect(page).to have_content "#{other_user.username}さんがあなたの投稿にいいねしました"
  end

  scenario "通知を全件削除" do
    user = FactoryBot.create(:user, :with_posts)
    other_user = FactoryBot.create(:user)
    sign_in_as other_user

    within ".header-menu" do
      click_link "投稿一覧"
    end

    first(".link_to_allpost").click

    find(".like_btn").click

    fill_in "comment_feild", with: "通知します"
    click_button "コメントを投稿する"
    expect(page).to have_content "通知します"

    within ".header-menu" do
      click_link "ログアウト"
    end
    expect(page).to have_content "ログアウトしました。"
    
    sign_in_as user

    within ".header-menu" do
      click_link "通知"
    end

    expect(page).to have_content "通知"
    expect(page).to have_content "#{other_user.username}さんがあなたの投稿にいいねしました"
    expect(page).to have_content "#{other_user.username}さんがあなたの投稿にコメントしました"

    find(".all-delete-notifications").click
    expect(page).to have_content "通知"
    expect(page).to have_content "通知はありません"
  end


end
