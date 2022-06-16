# frozen_string_literal: true

class Account < ApplicationRecord
  validates :account_uuid, :name, presence: true
end
