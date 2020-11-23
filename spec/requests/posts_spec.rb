require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "#create" do
    before do 
      @user = FactoryBot.create(:user)
    end
    context "有効な属性" do
      it "投稿が追加できること" do
        posts_params = FactoryBot.attributes_for(:post)
        sign_in @user
  
        expect {
          post posts_path, params: { post: posts_params }
        }.to change(@user.posts, :count).by(1)
      end
    end

    context "無効な属性" do
      it "投稿を追加できない" do
        posts_params = FactoryBot.attributes_for(:post, :invalid)
        sign_in @user
  
        expect {
          post posts_path, params: { post: posts_params }
        }.to_not change(@user.posts, :count)
      end
    end
  end
end
