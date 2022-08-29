# frozen_string_literal: true

class TeamBalancePresenter < ApplicationPresenter
  ATTRS = %i[balance balance_date team_id collaborator_id].freeze
  METHODS = %i[calculate_junior_balance seniority_count].freeze

  private
    def calculate_junior_seniority
      total_collaborators = TeamBalanceRepository.count_collaborators(id)
      total_juniors = TeamBalanceRepository.count_junior_collaborators(id)

      junior_balance = (total_juniors / total_collaborators) * 100 if total_junior.nil?

      junior_deviation = 50 - junior_balance
      junior_deviation.abs
    end

    def calculate_middle_seniority
      total_collaborators = TeamBalanceRepository.count_collaborators(id)
      total_middles = TeamBalanceRepository.count_middle_collaborators(id)

      middle_balance = (total_middles / total_collaborators) * 100 if total_middle.nil?

      middle_deviation = 30 - middle_balance
      middle_deviation.abs
    end

    def calculate_senior_seniority
      total_collaborators = TeamBalanceRepository.count_collaborators(id)
      total_seniors = TeamBalanceRepository.count_senior_collaborators(id)

      senior_balance = (total_seniors / total_collaborators) * 100 if total_senior.nil?

      senior_deviation = 20 - senior_balance
      senior_deviation.abs
    end

    def calculate_seniority_deviation(junior_deviation, middle_deviation, senior_deviation)
      seniority_deviation = junior_deviation + middle_deviation + senior_deviation
      seniority_deviation
    end

    def calculate_balance(seniority_deviation)
      100 - seniority_deviation
    end
end
