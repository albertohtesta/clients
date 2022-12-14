# frozen_string_literal: true

class Project < ApplicationRecord
  has_and_belongs_to_many :tech_stacks
  has_and_belongs_to_many :tools

  has_many :teams

  belongs_to :account

  validates :name, :start_date, presence: true

  def self.update_project_by_salesforce(account, opportunity)
    project = account.projects.where(salesforce_id: opportunity[:Id]).first_or_initialize
    project.update({ name: opportunity[:Name], start_date: Time.now, description: opportunity[:Description] })
    project.update(deleted_at: Time.now) if opportunity[:IsDeleted]
  end
end
