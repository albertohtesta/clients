# frozen_string_literal: true

class ManagerAccountsPresenter < ApplicationPresenter
  ATTRS = %i[id account_uuid name].freeze
  METHODS = %i[location last_follow_up_text priority role_debt alert team_balance
    performance morale velocity manager_id].freeze

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
    return "No follow ups found" if last_follow_up.nil? && last_metric_follow_up_date.nil?
    if last_follow_up.nil? || last_metric_follow_up_date.nil?
      date = last_follow_up.present? ? last_follow_up.follow_date : last_metric_follow_up_date
    else
      date = [last_follow_up.follow_date, last_metric_follow_up_date].max
    end
    "#{(Date.today - date).to_i} days ago"
  end

  def role_debt
    TeamRequirementRepository.role_deb_by_account(id).count
  end

  def alert
    (team_balance[:alert] && !team_balance[:attended_after_metric]) ||
    (performance[:alert] && !performance[:attended_after_metric]) ||
    (morale[:alert] && !morale[:attended_after_metric]) ||
    (velocity[:alert] && !velocity[:attended_after_metric])
  end

  def team_balance
    @team_balance ||= metric_priority("balance")
  end

  def performance
    @performance ||= metric_priority("performance")
  end

  def morale
    @morale ||= metric_priority("morale")
  end

  def velocity
    @velocity ||= metric_priority("velocity")
  end

  private
    def metric_priority(metric_type)
      return MetricPriority::PriorityCalculatorRepository.new(self, metric_type).priority unless self.projects.blank?

      {
        amount: 0,
        alert: "low",
        data_follow_up: []
      }
    end
end
