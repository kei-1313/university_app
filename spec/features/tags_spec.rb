require 'rails_helper'

RSpec.feature "Tags", type: :feature do
  context "タグ機能" do
    before do 
      @user = FactoryBot.create(:user)
      sign_in_as @user
    end

    scenario "投稿時にタグ付けできる" do
        within ".header-menu" do
          click_link "新規投稿" 
        end
        fill_in "title", with: "英語学習している人"
        fill_in "body", with: "英語学習している人募集"
        fill_in "tag_name", with: "英語"
        click_button "投稿する"
  
        expect(page).to have_content "新しく投稿しました"
        expect(page).to have_content "英語学習している人"
        expect(page).to have_content "英語学習している人募集"
        expect(page).to have_link "英語"
    end

    scenario "投稿時に複数タグ付けできる" do
        within ".header-menu" do
          click_link "新規投稿" 
        end
        fill_in "title", with: "英語学習している人"
        fill_in "body", with: "英語学習している人募集"
        fill_in "tag_name", with: "英語 語学学習 TOEIC"
        click_button "投稿する"
  
        expect(page).to have_content "新しく投稿しました"
        expect(page).to have_content "英語学習している人"
        expect(page).to have_content "英語学習している人募集"
        expect(page).to have_link "英語"
        expect(page).to have_link "語学学習"
        expect(page).to have_link "TOEIC"
    end

    scenario "タグをクリックでタグ検索" do
        within ".header-menu" do
          click_link "新規投稿" 
        end
        fill_in "title", with: "英語学習している人"
        fill_in "body", with: "英語学習している人募集"
        fill_in "tag_name", with: "英語 語学学習 TOEIC"
        click_button "投稿する"
  
        expect(page).to have_content "新しく投稿しました"
        expect(page).to have_content "英語学習している人"
        expect(page).to have_content "英語学習している人募集"
        expect(page).to have_link "英語"
        expect(page).to have_link "語学学習"
        expect(page).to have_link "TOEIC"

        click_link "英語"

        expect(page).to have_link "英語"
        expect(page).to have_content "英語学習している人"
        expect(page).to have_content "『英語』タグで検索1件"
        
    end

   scenario "他人投稿のタグを使って検索" do
    other_user = FactoryBot.create(:user)

      within ".header-menu" do
        click_link "新規投稿" 
      end
      fill_in "title", with: "英語学習している人"
      fill_in "body", with: "英語学習している人募集"
      fill_in "tag_name", with: "英語 語学学習 TOEIC"
      click_button "投稿する"

      expect(page).to have_content "新しく投稿しました"
      expect(page).to have_content "英語学習している人"
      expect(page).to have_content "英語学習している人募集"
      expect(page).to have_link "英語"
      expect(page).to have_link "語学学習"
      expect(page).to have_link "TOEIC"

      within ".header-menu" do
        click_link "ログアウト" 
      end
      expect(page).to have_content "ログアウトしました"

      sign_in_as other_user

      within ".header-menu" do
        click_link "投稿一覧" 
      end

      expect(page).to have_content "英語学習している人"
      click_link "英語"

      expect(page).to have_link "英語"
      expect(page).to have_content "英語学習している人"
      expect(page).to have_content "『英語』タグで検索1件"

   end
  end

  
end
