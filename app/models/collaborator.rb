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
  has_and_belongs_to_many :accounts, join_table: "accounts_collaborators"

  has_one_attached :avatar

  belongs_to :role

  validates :first_name, :last_name, :email, :uuid, presence: true

  # after_update :add_team_balance

  private
    def add_team_balance
      balance = TeamBalance.new
      balance.team_id = self.id
      balance.balance_date = self.balance_date
      balance.balance = TeamBalanceService.new(id).process
      balance.save
    end

    def balance_date
      Date.today
    end
end
