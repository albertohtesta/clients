# frozen_string_literal: true

class FollowHistory < ApplicationRecord
  belongs_to :account

  validates :follow_date, presence: true
end
