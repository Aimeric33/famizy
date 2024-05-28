FactoryBot.define do
  factory :event do
    association :family
    name { "Event Name" }
    description { "Event Description" }
    start_date { DateTime.now }
    end_date { DateTime.now + 1.hour }
    place { "Event Location" }
  end
end
