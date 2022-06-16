# frozen_string_literal: true

class Team < ApplicationRecord
  belongs_to :team_type

  validates :added_date, presence: true
end
