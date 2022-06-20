# frozen_string_literal: true

class Account < ApplicationRecord
  belongs_to :account_status

  validates :account_uuid, :name, presence: true
end
