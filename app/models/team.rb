# frozen_string_literal: true

class Team < ApplicationRecord
  has_many :collaborators_teams
  has_many :collaborators, through: :collaborators_teams
  has_many :investments

  belongs_to :team_type
  belongs_to :project

  validates :added_date, presence: true
end
