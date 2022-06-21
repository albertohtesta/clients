# frozen_string_literal: true

class Account < ApplicationRecord
  belongs_to :account_status
  belongs_to :manager, class_name: "Collaborator", foreign_key: :manager_id, optional: true

  has_many :projects
  has_many :payments

  validates :account_uuid, :name, presence: true

  def status
    account_status.status
  end

  def location
    city
  end

  def debt?
    payments.each do |payment|
      return true if payment.payment_date.nil? && payment.payday_limit < Time.now
    end
    false
  end

  def payment_status
    debt? ? "Debt" : "On Time"
  end

  def tech_stacks
    projects.map { |project| project.tech_stacks.pluck(:name) }.flatten.uniq
  end

  def tools
    projects.map { |project| project.tools.pluck(:name) }.flatten.uniq
  end

  def details
    {
      balance:,
      total_projects: projects.count,
      total_teams: projects.map { |project| project.teams.count }.sum
    }
  end

  def finance
    {
      blended_rate:,
      gross_profit:,
      payroll:,
      total_expenses:,
      total_revenue:
    }
  end

  def health
    {
      client_satisfaction:,
      moral:
    }
  end

  def productivity_kpis
    {
      bugs_detected:,
      permanence:,
      productivity:,
      speed:
    }
  end
end
