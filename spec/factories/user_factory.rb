FactoryBot.define do
  factory :user do
    name { "John Doe" }
    email { "johndoe@famizy.com" }
    password { "12345678" }
    password_confirmation { "12345678" }
    birth_date { Date.parse("1996-01-01") }
  end
end
