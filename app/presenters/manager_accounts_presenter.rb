# frozen_string_literal: true

class ManagerAccountsPresenter < ApplicationPresenter
  ATTRS = %i[id name].freeze
  METHODS = %i[location last_follow_up_text priority role_debt alert team_balance client_management performance gross_margin morale].freeze

  def location
    city
  end

  def priority
    default_priority = "low"

    return default_priority if last_follow_up.nil?

    return "high" if AccountPriority::PriorityCalculatorRepository.new(self, last_follow_up.follow_date).high_priority

    return "medium" if AccountPriority::PriorityCalculatorRepository.new(self, last_follow_up.follow_date).medium_priority
  end

  def last_follow_up_text
    return "#{(Date.today - last_follow_up.follow_date).to_i} days ago" if last_follow_up

    "No follow ups found"
  end

  def role_debt
    TeamRequirementRepository.role_deb_by_account(id).count
  end

  def alert
    # TODO: Needs alert depending of the priority and some rules
    true
  end

  def team_balance
    {
      amount: 85,
      alert: temp_active_sample
    }
  end

  def client_management
    {
      amount: 85,
      alert: temp_active_sample
    }
  end

  def performance
    {
      amount: 85,
      alert: temp_active_sample
    }
  end

  def gross_margin
    {
      amount: 85,
      alert: temp_active_sample
    }
  end

  def morale
    {
      amount: 85,
      alert: temp_active_sample
    }
  end

  private
    # TODO: this method is just temporally while bussines rules are defined and added into the project
    def temp_active_sample
      true
    end

    def last_follow_up
      @last_follow_up ||= AccountFollowUpRepository.last_follow_up_by_account(id).last
    end
end
