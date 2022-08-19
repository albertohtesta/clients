# frozen_string_literal: true

class AccountPresenter < ApplicationPresenter
  ATTRS = %i[id uuid name contact_name contact_email account_web_page].freeze
  METHODS = %i[info review_outdated? location tech_stacks role_debt
                  tools payment_status status details finance health productivity_kpis].freeze

  def location
    city
  end

  def info
    "#{uuid} #{name} #{contact_name} #{contact_email}"
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

  def payment_status
    debt? ? "Debt" : "On Time"
  end

  def review_outdated?
    # TODO: this is example random data, this needs to be pulled from follow up model
    [true, false].sample
  end

  def role_debt
    AccountRepository.role_debt_by_id(__getobj__.id)
  end
end
