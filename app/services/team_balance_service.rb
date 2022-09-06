# frozen_string_literal: true

class TeamBalanceService < ApplicationService
  def initialize(team_id)
    @team_id = team_id
  end

  def process
    calculate_junior_seniority
    calculate_middle_seniority
    calculate_senior_seniority
    calculate_seniority_deviation
  end

  private
    attr_reader :team_id

    def calculate_junior_seniority
      total_collaborators = TeamRepository.find_all_collaborators(team_id).size
      total_juniors = TeamRepository.find_all_junior_collaborators(team_id).size

      junior_balance = (total_juniors / total_collaborators rescue 0) * 100 unless total_juniors.nil?

      @junior_deviation = (50 - junior_balance).abs
    end

    def calculate_middle_seniority
      total_collaborators = TeamRepository.find_all_collaborators(team_id).size
      total_middles = TeamRepository.find_all_middle_collaborators(team_id).size

      middle_balance = (total_middles / total_collaborators rescue 0) * 100 unless total_middles.nil?

      @middle_deviation = (30 - middle_balance).abs
    end

    def calculate_senior_seniority
      total_collaborators = TeamRepository.find_all_collaborators(team_id).size
      total_seniors = TeamRepository.find_all_senior_collaborators(team_id).size

      senior_balance = (total_seniors / total_collaborators rescue 0) * 100 unless total_seniors.nil?

      @senior_deviation = (20 - senior_balance).abs
    end

    def calculate_seniority_deviation
      seniority_deviation = @junior_deviation + @middle_deviation + @senior_deviation
      calculate_balance(seniority_deviation)
    end

    def calculate_balance(seniority_deviation)
      100 - seniority_deviation
    end
end
