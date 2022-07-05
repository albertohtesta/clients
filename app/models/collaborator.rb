# frozen_string_literal: true

class Collaborator < ApplicationRecord
  has_and_belongs_to_many :teams
  has_and_belongs_to_many :tech_stacks
  has_and_belongs_to_many :tools
  has_many :accounts, foreign_key: :manager_id

  validates :name, :email, :uuid, presence: true

  def accounts_count
    accounts.size
  end
end
