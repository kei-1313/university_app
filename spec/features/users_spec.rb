require 'rails_helper'

RSpec.feature "Users", type: :feature do
    scenario "ログアウト" do
      user = FactoryBot.create(:user)
      sign_in_as user

      within ".header-menu" do
        click_link 'ログアウト'
      end

      expect(page).to have_content "ログアウトしました。"
      expect(page).to have_content "新規登録"
      expect(page).to have_content "ログイン"
    end

    context "ログインユーザ" do
      scenario "自分のプロフィール変更" do
        user = FactoryBot.create(:user)
        sign_in_as user
  
        within ".header-menu" do
          click_link "マイページ"
        end

        click_link "編集"

        fill_in "ユーザー名", with: "田中太郎"
        fill_in "メールアドレス", with: "taro@gmail.com"
        fill_in "more-than-six", with: "tarotanaka"
        fill_in "確認用パスワード", with: "tarotanaka"
        fill_in "現在のパスワード", with: "tanaka"
        fill_in "プロフィール", with: "経済学部の3年生です"

        click_button "更新"

        expect(page).to have_content "アカウント情報を変更しました。"

        within ".header-menu" do
          click_link "ユーザー一覧"
        end

        expect(page).to have_content "田中太郎"
        expect(page).to have_content "経済学部の3年生です"
      end
    end

    context "ログインしていないユーザ" do
      scenario "他人のプロフィールで編集ボタンがない" do
        user = FactoryBot.create(:user)
        other_user = FactoryBot.create(:user)
        sign_in_as user

        within ".header-menu" do
          click_link "ユーザー一覧"
        end

        page.all(".user-index-btn")[1].click

        expect(page).to_not have_link "編集"
        expect(page).to have_content "ユーザー情報"
      end
    end

end
