FactoryBot.define do
  factory :meal do
    association :family, factory: :family
    association :recipe, factory: :recipe
    date { Date.today }
    meal_type { :lunch }
    other_name { "MyString" }
  end
end
