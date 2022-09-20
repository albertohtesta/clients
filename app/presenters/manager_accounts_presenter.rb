# frozen_string_literal: true

class ManagerAccountsPresenter < ApplicationPresenter
  ATTRS = %i[id account_uuid name].freeze
  METHODS = %i[location last_follow_up_text priority role_debt alert team_balance
    client_management performance gross_margin morale velocity manager_id].freeze

  def location
    city
  end

  def priority
    if last_follow_up.nil?
      just_assigned = manager_started_date.nil? || manager_started_date > 1.month.ago
      return just_assigned ? "medium" : "high"
    end
    AccountPriority::PriorityCalculatorRepository.new(self, last_follow_up.follow_date).priority
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
    metric_priority("balance")
  end

  def client_management
    metric_priority("client_management")
  end

  def performance
    metric_priority("performance")
  end

  def gross_margin
    metric_priority("gross_margin")
  end

  def morale
    metric_priority("morale")
  end

  def velocity
    metric_priority("velocity")
  end

  private
    # TODO: this method is just temporally while bussines rules are defined and added into the project
    def temp_active_sample
      true
    end


    def metric_priority(metric_type)
      return MetricPriority::PriorityCalculatorRepository.new(self, metric_type).priority unless self.projects.blank?

      {
        amount: 0,
        alert: "low",
        data_follow_up: []
      }
    end
end
