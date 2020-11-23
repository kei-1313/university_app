require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'commestsテーブルのバリデーション' do
    let(:comment) { build :comment }
    describe 'バリデーションがかかっていない場合' do
      it 'contentに正式な値がある場合' do
        expect(comment).to be_valid
      end      
    end

    describe 'バリデーションがかかっている場合' do
      let(:comment) { build :comment, content: content }
      context 'コメントできる' do
        context '500文字以内の場合' do
          let(:content) {'あ' * 499}
          it '499文字' do 
            expect(comment).to be_valid
          end
        end
      end

      context 'コメントできない' do
        context '空欄の場合' do
          let(:content) {''}
          it 'コメント(content)が空欄の場合' do
            comment.valid?
            expect(comment.errors[:content]).to include('を入力してください')
          end      
        end

        context '500文字以上の場合' do
          let(:content) {'あ' *  501}
          it '501文字' do 
            comment.valid?
            expect(comment.errors[:content]).to include('は500文字以内で入力してください')
          end
        end
      end

    end
  end
end
