require 'rails_helper'

RSpec.feature "Notifications", type: :feature do
  scenario "フォローされた場合の通知" do
    user = FactoryBot.create(:user)
    other_user = FactoryBot.create(:user)
    sign_in_as other_user

    within ".header-menu" do
      click_link "ユーザ一覧"
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

  scenario "自分の投稿にコメントされた場合の通知" do
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

  scenario "自分がコメントした投稿に誰かがコメントしたときの通知（コメントの返信など）" do
    user = FactoryBot.create(:user)
    other_user = FactoryBot.create(:user, :with_posts)
    sign_in_as user

    within ".header-menu" do
      click_link "投稿一覧"
    end
    first(".link_to_allpost").click

    fill_in "comment_feild", with: "コメント"
    click_button "コメントを投稿する"
    expect(page).to have_content "コメント"

    within ".header-menu" do
      click_link "ログアウト"
    end
    expect(page).to have_content "ログアウトしました。"
    
    sign_in_as other_user

    within ".header-menu" do
      click_link "投稿一覧"
    end
    first(".link_to_allpost").click

    fill_in "comment_feild", with: "コメントありがとう"
    click_button "コメントを投稿する"
    expect(page).to have_content "コメントありがとう"

    within ".header-menu" do
      click_link "ログアウト"
    end
    expect(page).to have_content "ログアウトしました。"

    sign_in_as user

    within ".header-menu" do
      click_link "通知"
    end
   
    expect(page).to have_content "通知"
    expect(page).to have_content "#{other_user.username}さんが#{other_user.username}さんの投稿にコメントしました"
  end

  scenario "通知を全件削除" do
    user = FactoryBot.create(:user, :with_posts)
    other_user = FactoryBot.create(:user)
    sign_in_as other_user

    within ".header-menu" do
      click_link "投稿一覧"
    end

    first(".link_to_allpost").click

    fill_in "comment_feild", with: "通知します"
    click_button "コメントを投稿する"
    fill_in "comment_feild", with: "通知しました"
    click_button "コメントを投稿する"
    expect(page).to have_content "通知します"
    expect(page).to have_content "通知しました"

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
    expect(page).to have_content "#{other_user.username}さんがあなたの投稿にコメントしました"

    find(".all-delete-notifications").click
    expect(page).to have_content "通知"
    expect(page).to have_content "通知はありません"
  end


end
