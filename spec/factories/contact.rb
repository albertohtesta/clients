# frozen_string_literal: true

FactoryBot.define do
  factory :contact do
    first_name { "First name" }
    last_name { "my string" }
    email { "email@email.com" }
    salesforce_id { "Id" }
    phone { "23345234" }
    account
  end
end
