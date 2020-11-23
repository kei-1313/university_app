require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'postsテーブルのバリデーション' do
    describe 'バリデーションがかかっていない場合' do
      let(:post) { build :post }
      it 'titleとbodyに正式な値がある場合' do
        expect(post).to be_valid
      end
    end

    describe 'バリデーションがかかっている場合' do
      describe 'titleのバリデーション' do
        let(:post) { build :post, title: title }

        context '投稿できる' do
          context '50字以内の場合' do
            let(:post) {build :post, title: 'タ' * 49 }
            it '49字' do
              expect(post).to be_valid
            end
          end
        end

        context '投稿できない' do
          context '空欄の場合' do
            let(:title) {''}
            it '空欄' do
              post.valid?
              expect(post.errors[:title]).to include('を入力してください')
            end
          end
  
          context '50字以上の場合' do
            let(:post) {build :post, title: 'タ' * 51 }
            it '51字' do
              post.valid?
              expect(post.errors[:title]).to include('は50文字以内で入力してください')
            end
          end
        end
      end


      describe 'bodyのバリデーション' do
        let(:post) { build :post, body: body }
        context '投稿できる' do 
          context '3文字以上の場合' do
            let(:body) { 'ああああ' }
            it '4文字' do
              expect(post).to be_valid
            end
          end

          context '500文字以内の場合' do
            let(:body) { 'あ' * 499 }
            it '499文字' do
              expect(post).to be_valid
            end
          end
        end

        context '投稿できない' do
          context '空欄の場合' do
            let(:body) {''}
            it '空欄' do
              post.valid?
              expect(post.errors[:body]).to include('を入力してください')
            end
          end

          context '3文字以下の場合' do
            let(:body) { 'ああ' }
            it '2文字' do
              post.valid?
              expect(post.errors[:body]).to include('は3文字以上で入力してください')
            end
          end

          context '500文字以上の場合' do
            let(:body) { 'あ' * 501 }
            it '501文字' do
              post.valid?
              expect(post.errors[:body]).to include('は500文字以内で入力してください')
            end
          end

        end
      end

    end
  end
end
