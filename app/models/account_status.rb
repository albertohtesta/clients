# frozen_string_literal: true

class AccountStatus < ApplicationRecord
  validates :status, presence: true

  pluck(:status_code, :id).each do |status_code, _id|
    define_singleton_method "#{status_code}_status" do
      where(status_code:).first
    end
  end
end
