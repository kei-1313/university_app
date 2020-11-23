require 'rails_helper'

RSpec.describe "Comments", type: :request do
  describe "#create" do
    before do 
      @user = FactoryBot.create(:user)
      @other_user = FactoryBot.create(:user, :with_posts)
    end

   context "有効な属性" do
      it "コメントが追加できること" do
        comments_params = FactoryBot.attributes_for(:comment)
        sign_in @user
  
        expect {
          post post_comments_path(@other_user.posts[0]), params: { comment: comments_params }
        }.to change(@user.comments, :count).by(1)
      end
    end
  end
end
