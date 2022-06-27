# frozen_string_literal: true

class AccountStatus < ApplicationRecord
  validates :status, presence: true
end
