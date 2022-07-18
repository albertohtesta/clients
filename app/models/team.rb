# frozen_string_literal: true

class Team < ApplicationRecord
  has_many :collaborators_teams
  has_many :projects_teams
  has_many :projects, through: :projects_teams
  has_many :collaborators, through: :collaborators_teams

  belongs_to :team_type

  validates :added_date, presence: true
end
