# frozen_string_literal: true

class Team < ApplicationRecord
  has_many :collaborators_teams
  has_many :collaborators, through: :collaborators_teams
  has_many :metrics, as: :related
  has_many :investments
  has_many :team_requirements
  has_many :surveys
  has_many :team_balances

  belongs_to :team_type
  belongs_to :project

  validates :added_date, presence: true

  after_create :team_balance

  def team_balance
    TeamBalanceService.new(team_id).process
  end


  # trigger.after(:insert) do
  #   "UPDATE teams SET NEW.balance = TeamBalanceService.process"
  # end

  # trigger.after(:update).of(:collaborators) do
  #   # "INSERT INTO user_changes(id, name) VALUES(NEW.id, NEW.name);"
  # end
