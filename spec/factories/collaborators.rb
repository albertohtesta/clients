# frozen_string_literal: true

FactoryBot.define do
  factory :collaborator do
    first_name { "MyString" }
    last_name { "MyString" }
    email { "MyString" }
    uuid { "MyString" }
    position { "Developer" }
    role
  end
end
