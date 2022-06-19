# frozen_string_literal: true

class Team < ApplicationRecord
  belongs_to :team_type
  has_and_belongs_to_many :projects
  has_and_belongs_to_many :colaborators

  validates :added_date, presence: true
end
