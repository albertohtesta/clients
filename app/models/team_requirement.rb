# frozen_string_literal: true

class TeamRequirement < ApplicationRecord
  belongs_to :team
  belongs_to :collaborator
  belongs_to :role

  has_many :team_requirements_tech_stacks
  has_many :teck_stacks, through: :team_requirements_tech_stacks

  validates :team, :seniority, :role, presence: true

  enum seniority: SENIORITY_TYPES
end
