FactoryBot.define do
  factory :project do
    name { "MyString" }
    start_date { "2022-06-14" }
    end_date { "2022-06-14" }
    description { "MyString" }
    delivery_dates { "2022-06-14" }
    demo_dates { "2022-06-14" }
    account { nil }
  end
end
