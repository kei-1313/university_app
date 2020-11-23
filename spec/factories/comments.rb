FactoryBot.define do
  factory :comment do
    content {'参加したいです！！！'}
    association :user
    association :post

    trait :invalid do
      content {''}
    end
  end
end
