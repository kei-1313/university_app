require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'usersテーブルのバリデーション' do

    describe 'バリデーションがかかっていない場合' do
      let(:user) { build :user }
      it 'username,student_id,email,passwordに正式な値がある場合' do
        expect(user).to be_valid
      end
    end

    describe 'バリデーションがかかっている場合' do

      describe 'usernameのバリデーション' do
        let(:user) { build :user, username: username }
        context '登録される' do
          context '17文字の時' do
            let(:username) {'たなかたなかたなかたなかたなかたな'}
            it '17文字の時' do
              expect(user).to be_valid
            end
          end
        end

        context '登録されない' do
          context '空欄の場合' do
            let(:username) {''}
            it '空欄' do
              user.valid?
              expect(user.errors[:username]).to include('を入力してください')
            end
          end
          
          context '18文字以上の場合' do
            let(:username) {'たなかたなかたなかたなかたなかたなかた'}
            it '19文字' do
              user.valid?
              expect(user.errors[:username]).to include('は18文字以内で入力してください')
            end
          end
        end
      end

      describe 'student_idのバリデーション' do
       let(:user) { build :user, student_id: student_id }
        context '登録されない' do
          context '7文字以下の場合' do
            let(:student_id) {'12RR77'}
            it '6文字' do
              user.valid?
              expect(user.errors[:student_id]).to include('は7文字以上で入力してください')
            end
          end

          context '8文字以上の場合' do
            let(:student_id) {'12RR77777'}
            it '9文字' do
              user.valid?
              expect(user.errors[:student_id]).to include('は8文字以内で入力してください')
            end
          end

          context '半角大文字英字、半角数字以外の文字が入っている場合' do
            let(:student_id) {'あ77RR77'}
            it '1文字紛れている場合' do
              user.valid?
              expect(user.errors[:student_id]).to include('は半角7~8文字で英大文字と数字で入力して下さい')
            end
          end

          context '既に登録されている学籍番号が使えない' do
            let(:student_id) {'33EE333'}
            before do
              FactoryBot.create(:unique_user)
            end
            it '一意性の確認' do
              user.valid?
              expect(user.errors[:student_id]).to include('はすでに存在します')
            end
          end

          context '空欄の場合' do
            let(:student_id) {''}
            it '空欄' do
              user.valid?
              expect(user.errors[:student_id]).to include('を入力してください')
            end
          end
        end
      end

      describe 'emailのバリデーション' do
        let(:user) { build :user, email: email }
        context '登録されない' do
          context '空欄の場合' do
            let(:email) {''}
            it '空欄' do
              user.valid?
              expect(user.errors[:email]).to include('が入力されていません。')
            end
          end

          context '既に使用されている場合' do
            let(:email) {'uniqueman@gmail.com'}
            before do
              FactoryBot.create(:unique_user)
            end
            it '使用済み' do
              user.valid?
              expect(user.errors[:email]).to include('は既に使用されています。')
            end
          end
        end
      end


      describe 'passwordのバリデーション' do
        let(:user) { build :user, password: password }

        context '登録される' do
          let(:password) {'tanakaa'}
          context '6文字以上の場合' do
            it '7文字' do
              expect(user).to be_valid
            end
          end
        end
        
        context '登録されない' do
          context '空欄の場合' do
            let(:password) {''}
            it 'パスワード(password)が空欄の場合' do
              user.valid?
              expect(user.errors[:password]).to include('が入力されていません。')
            end
          end
    
          context '6文字未満の場合' do
            let(:password) {'tanak'}
            it '5文字' do
              user.valid?
              expect(user.errors[:password]).to include('は6文字以上に設定して下さい。')
            end
          end

        end
      end

    end
  end

 
end
