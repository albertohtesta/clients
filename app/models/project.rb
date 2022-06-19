# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :account
  has_and_belongs_to_many :teams
  has_and_belongs_to_many :tech_stacks
  has_and_belongs_to_many :tools

  validates :name, :start_date, presence: true
end
