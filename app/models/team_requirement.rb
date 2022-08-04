# frozen_string_literal: true

class TeamRequirement < ApplicationRecord
  belongs_to :account
  belongs_to :team
  belongs_to :collaborator, optional: true
  belongs_to :role

  has_and_belongs_to_many :tech_stacks

  validates :account, :team, :seniority, :role, presence: true

  enum seniority: SENIORITY_TYPES
end
