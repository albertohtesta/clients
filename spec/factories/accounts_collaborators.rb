# frozen_string_literal: true

FactoryBot.define do
  factory :accounts_collaborator do
    account
    collaborator
  end
end
