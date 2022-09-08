# frozen_string_literal: true

class TeamBalanceService < ApplicationService
  def initialize(team_id)
    @team_id = team_id
    @total_collaborators = TeamRepository.find_all_collaborators(team_id).size
  end

  def process
    seniority_deviation = junior_seniority_desviation + middle_seniority_desviation + senior_seniority_desviation
    calculate_balance(seniority_deviation)
  end

  private
    attr_reader :team_id, :total_collaborators

    def junior_seniority_desviation
      total_juniors = TeamRepository.find_all_collaborators_by_seniority(team_id, SENIORITY_TYPES[:junior])
      junior_key_percent = total_collaborators * 0.50
      junior_unbalance = (total_juniors.size - junior_key_percent) * 100 / total_collaborators unless total_juniors.size.zero?
      junior_unbalance || 33
    end

    def middle_seniority_desviation
      total_middles = TeamRepository.find_all_collaborators_by_seniority(team_id, SENIORITY_TYPES[:middle])
      middle_key_percent = total_collaborators * 0.30
      middle_unbalance = (total_middles.size - middle_key_percent) * 100 / total_collaborators unless total_middles.size.zero?
      middle_unbalance || 33
    end

    def senior_seniority_desviation
      total_seniors = TeamRepository.find_all_collaborators_by_seniority(team_id, SENIORITY_TYPES[:senior])
      senior_key_percent = total_collaborators * 0.20
      senior_unbalance = (total_seniors.size - senior_key_percent) * 100 / total_collaborators unless total_seniors.size.zero?
      senior_unbalance || 33
    end
end
