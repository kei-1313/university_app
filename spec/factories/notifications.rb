FactoryBot.define do
  factory :notification do
    association :visitor
    association :visited
  end
end
