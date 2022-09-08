# frozen_string_literal: true

class Collaborator < ApplicationRecord
  has_many :posts
  has_many :collaborators_teams
  has_many :teams, through: :collaborators_teams
  has_many :accounts, foreign_key: :manager_id
  has_many :collaborators_badges
  has_many :badges, through: :collaborators_badges

  has_and_belongs_to_many :tech_stacks
  has_and_belongs_to_many :tools
  has_many :account_contact_collaborators

  has_one_attached :avatar

  belongs_to :role

  validates :first_name, :last_name, :email, :uuid, presence: true

  after_update :calculate_team_balance

  private
    def calculate_team_balance
      self.teams.each do |team|
        team_balance = TeamBalanceService.new(team.id).process
        TeamBalance.new({ team_id: team.id, balance_date: Date.today, balance: team_balance }).save
      end
    end
end
