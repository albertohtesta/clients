# frozen_string_literal: true

class Collaborator < ApplicationRecord
  has_many :posts
  has_many :collaborators_teams
  has_many :teams, through: :collaborators_teams
  has_many :accounts, foreign_key: :manager_id

  has_and_belongs_to_many :tech_stacks
  has_and_belongs_to_many :tools

  has_one_attached :avatar

  belongs_to :role

  validates :first_name, :last_name, :email, :uuid, presence: true
end
