# frozen_string_literal: true

FactoryBot.define do
  factory :account do
    account_uuid { "MyString" }
    name { "MyString" }
    contact_name { "MyString" }
    contact_email { "MyString" }
    contact_phone { "MyString" }
    account_web_page { "MyString" }
    service_duration { "MyString" }
    account_status
    manager { association :collaborator }
  end
end
