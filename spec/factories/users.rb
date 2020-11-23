FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "tanaka#{n}"}
    sequence(:student_id) {|n| "00EE00#{n}"}
    sequence(:email) { |n| "tanaka#{n}@gmail.com"}
    password {"tanaka"}

    factory :unique_user do
      username {"ユニークマン"}
      student_id {"33EE333"}
      email {"uniqueman@gmail.com"}
      password{"uniqueman"}
    end

    trait :with_posts do
      after(:create) { |user| create_list(:post, 5, user: user) }
    end
    
  end
end


