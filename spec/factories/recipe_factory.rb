FactoryBot.define do
  factory :recipe do
    association :family, factory: :family
    name { Faker::Food.dish }
    recipe_type { :main_course }
  end
end
