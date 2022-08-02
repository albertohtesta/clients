# frozen_string_literal: true

FactoryBot.define do
  factory :account_collaborator do
    account
    collaborator
  end
end
