FactoryBot.define do
  factory :post do
    title {'軟式野球サークル部員募集中'}
    body {'軟式野球サークルに参加したい人はdmしてください'}
    association :user

    trait :with_comments do
      after(:create) {|post| create_list(:comment, 3, post: post) }
    end

    trait :invalid do
      title {''}
      body {''}
    end
  end
end
