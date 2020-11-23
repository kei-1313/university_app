require 'rails_helper'

RSpec.feature "Comments", type: :feature do
  context "ログインユーザ" do
    before do
      @post = FactoryBot.create(:post, :with_comments)
      sign_in_as @post.user
    end
    scenario "ユーザは他人のコメントの削除ボタンは見えない'"do
        within ".header-menu" do
          click_link "投稿一覧"
        end
        first(".link_to_allpost").click

        expect(page).to_not have_css ".comment-delete-btn"
        expect(page).to have_content "コメントを投稿する"
    end
  end

  scenario "投稿が削除されるとコメントも削除される" do
    user = FactoryBot.create(:user, :with_posts)
    other_user = FactoryBot.create(:user)
    sign_in_as other_user

    within ".header-menu" do
      click_link "投稿一覧"
    end
    first(".link_to_allpost").click

    fill_in "comment_feild", with: "通知します"
    click_button "コメントを投稿する"
    fill_in "comment_feild", with: "コメントします"
    click_button "コメントを投稿する"
    expect(page).to have_content "通知します"
    expect(page).to have_content "コメントします"

    within ".header-menu" do
      click_link "ログアウト"
    end
    expect(page).to have_content "ログアウトしました。"

    sign_in_as user

    expect {
      within ".header-menu" do
        click_link "投稿一覧"
      end
      first(".link_to_allpost").click
  
      click_link "削除する"
      expect(page).to have_content "投稿を削除しました"
    }.to change(other_user.comments, :count).by(-2)
  end
end
