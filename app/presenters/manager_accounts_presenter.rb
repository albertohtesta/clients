# frozen_string_literal: true

class ManagerAccountsPresenter < ApplicationPresenter
  ATTRS = %i[id account_uuid name minilogo].freeze
  METHODS = %i[location collaborators_number collaborators last_follow_up_text priority role_debt alert team_balance
    performance morale velocity manager_id].freeze

  def location
    city
  end

  def role_debt
    TeamRequirementRepository.role_deb_by_account(id).count
  end

  def priority
    statuses = []
    statuses.push(team_balance[:alert])
    statuses.push(performance[:alert])
    statuses.push(morale[:alert])
    statuses.push(priority_on_account_follow_up)
    return ALERT[:high] if statuses.any? ALERT[:high]

    return ALERT[:medium] unless (statuses & [ALERT[:medium], ALERT[:no_connector], ALERT[:no_team]]).empty?

    ALERT[:low]
  end

  def alert
    statuses = []
    statuses.push(team_balance[:alert]) unless team_balance[:attended_after_metric]
    statuses.push(performance[:alert]) unless performance[:attended_after_metric]
    statuses.push(morale[:alert]) unless morale[:attended_after_metric]
    statuses.push(priority_on_account_follow_up)
    return ALERT[:no_dataset] unless (statuses & [ALERT[:no_connector], ALERT[:no_team]]).empty?

    return ALERT[:high] if statuses.any? ALERT[:high]

    return ALERT[:medium] if statuses.any? ALERT[:medium]

    ALERT[:low]
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

  def priority_on_account_follow_up
    if last_follow_up_date.nil?
      just_assigned = manager_started_date.nil? || manager_started_date > 1.month.ago
      return just_assigned ? "medium" : "high"
    end
    "low"
  end

  def last_follow_up_text
    return "No follow ups found" if last_follow_up_date.nil?

    days = (Date.today - last_follow_up_date).to_i
    days == 0 ? "Today" : "#{days} days ago"
  end

  def collaborators_number
    collaborators.size
  end

  def collaborators
    @collaborators ||= CollaboratorPresenter.json_collection(CollaboratorRepository.collaborators_by_account(self))
  end

  private
    def metric_priority(metric_type)
      priority =
        case metric_type
        when METRICS_TYPES[:velocity] then
          MetricPriority::VelocityCalculatorRepository.new(self).priority
        else
          MetricPriority::PriorityCalculatorRepository.new(self, metric_type).priority
        end
      priority[:alert] = ALERT[:no_team] if collaborators_number == 0
      if !connector_enabled && (metric_type == METRICS_TYPES[:velocity] || metric_type == METRICS_TYPES[:performance])
        priority[:alert] = ALERT[:no_connector]
      end
      priority
    end

    def connector_enabled
      @connector_enabled ||= self.teams.where.not(board_id: nil).any?
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
