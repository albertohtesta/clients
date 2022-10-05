# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    title { "MyString" }
    description { "MyText" }
    collaborator
    post { nil }
    project
  end
end
