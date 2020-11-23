require 'rails_helper'

RSpec.feature "Posts", type: :feature do
  context "ログインユーザ" do 
    before do
      @user = FactoryBot.create(:user, :with_posts)
      sign_in_as @user
    end
    scenario "ログインユーザは投稿できる"  do
      expect {
        within ".header-menu" do
          click_link "新規投稿" 
        end
        fill_in "title", with: "部員募集"
        fill_in "body", with: "部員募集しています"
        click_button "投稿する"
  
        expect(page).to have_content "新しく投稿しました"
        expect(page).to have_content "部員募集"
        expect(page).to have_content "部員募集しています"
  
      }.to change(@user.posts, :count).by(1)
    end
  
    scenario "ログインユーザは自分の投稿を編集できる" do
      within ".header-menu" do
        click_link "マイページ"
      end
      
      first(".link_to_mypost").click
      click_link "編集する"
      fill_in "title", with: "サッカーサークル部員募集"
      fill_in "body", with: "サッカーサークル部員募集しています"
      click_button "投稿する"
      
      expect(page).to have_content "投稿を編集しました"
      expect(page).to have_content "サッカーサークル部員募集"
      expect(page).to have_content "サッカーサークル部員募集しています"
    end

    scenario "ログインユーザは自分の投稿を削除できる" do
      expect {
        within ".header-menu" do
          click_link "マイページ"
        end
        first(".link_to_mypost").click
        click_link "削除する"

        expect(page).to have_content "投稿を削除しました"
        expect(page).to have_content "投稿一覧"
        expect(page).to have_button "検索"

      }.to change(@user.posts, :count).by(-1)
    end
  end

  context "ログインしていないユーザ" do
    before do
      @user = FactoryBot.create(:user, :with_posts)
      @other_user = FactoryBot.create(:user)
      sign_in_as @other_user
    end

    scenario "他人の投稿には編集ボタンと削除ボタンがない" do
      within ".header-menu" do
        click_link "投稿一覧"
      end
      
      first(".link_to_allpost").click
      expect(page).to_not have_content "編集する"
      expect(page).to_not have_content "削除する"
    end
  end

  context '投稿検索' do
    before do
      @post1 = FactoryBot.create(:post, title: 'テニスサークルに興味がある方')
      @post2 = FactoryBot.create(:post, title: 'バトミントンサークルに興味がある方')
      @post3 = FactoryBot.create(:post, title: 'テニスサークルのイベントのお知らせ')
  
      sign_in_as @post1.user
    end

    scenario '投稿の検索あり(全部に共通するワード)' do
      within ".header-menu" do
        click_link '投稿一覧'
      end

      find(".seach-text-field").set("サークル")
      click_button '検索'

      expect(page).to have_content "検索結果"
      expect(page).to have_content "3件"
      expect(page).to have_content @post1.title
      expect(page).to have_content @post2.title
      expect(page).to have_content  @post3.title
    end

    scenario '投稿の検索あり(特定のタイトルに共通するワード)' do
      within ".header-menu" do
        click_link '投稿一覧'
      end

      find(".seach-text-field").set("テニスサークル")
      click_button '検索'

      expect(page).to have_content "検索結果"
      expect(page).to have_content "2件"
      expect(page).to have_content @post1.title
      expect(page).to have_content  @post3.title
    end


    scenario '投稿の検索なし' do
      within ".header-menu" do
        click_link '投稿一覧'
      end

      find(".seach-text-field").set("サッカーサークル")
      click_button '検索'

      expect(page).to have_content "検索結果"
      expect(page).to have_content "0件"
      expect(page).to_not have_content @post1.title
      expect(page).to_not have_content  @post2.title
      expect(page).to_not have_content  @post3.title
    end
  end

end
