# frozen_string_literal: true

class ManagerAccountsPresenter < ApplicationPresenter
  ATTRS = %i[id account_uuid name minilogo].freeze
  METHODS = %i[location collaborators_number last_follow_up_text priority role_debt alert team_balance
    client_management performance gross_margin morale velocity manager_id].freeze

  def location
    city
  end

  def priority
    # deprecated. TODO: remove duplicated attributes
    alert
  end

  def last_follow_up_text
    return "No follow ups found" if last_follow_up_date.nil?

    "#{(Date.today - last_follow_up_date).to_i} days ago"
  end

  def role_debt
    TeamRequirementRepository.role_deb_by_account(id).count
  end

  def alert
    statuses = []
    statuses.push(team_balance[:alert]) unless team_balance[:attended_after_metric]
    statuses.push(performance[:alert]) unless performance[:attended_after_metric]
    statuses.push(morale[:alert]) unless morale[:attended_after_metric]
    statuses.push(priority_on_account_follow_up)

    return "high" if statuses.any? "high"

    return "medium" if statuses.any? "medium"

    "low"
  end

  def priority_on_account_follow_up
    if last_follow_up_date.nil?
      just_assigned = manager_started_date.nil? || manager_started_date > 1.month.ago
      return just_assigned ? "medium" : "high"
    end
    "low"
  end

  def team_balance
    @team_balance ||= metric_priority(METRICS_TYPES[:balance])
  end

  def performance
    @performance ||= metric_priority(METRICS_TYPES[:performance])
  end

  def morale
    @morale ||= metric_priority(METRICS_TYPES[:morale])
  end

  def velocity
    @velocity ||= metric_priority(METRICS_TYPES[:velocity])
  end

  private
    def metric_priority(metric_type)
      MetricPriority::PriorityCalculatorRepository.new(self, metric_type).priority
    end

    def last_follow_up_date
      return if last_follow_up.nil? && last_metric_follow_up_date.nil?

      if last_follow_up.nil? || last_metric_follow_up_date.nil?
        return last_follow_up.present? ? last_follow_up.follow_date : last_metric_follow_up_date
      end
      [last_follow_up.follow_date, last_metric_follow_up_date].max
    end

    def last_metric_follow_up_date
      @last_metric_follow_up_date ||= MetricPriority::PriorityCalculatorRepository.last_follow_up_date(id)
    end
end
