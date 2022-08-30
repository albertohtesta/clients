# frozen_string_literal: true

class TeamBalanceService < ApplicationService
  def calculate_seniority
    total_collaborators = TeamBalanceRepository.count_collaborators(id).count

    if seniority == "SENIOR"
      total_seniors = TeamBalanceRepository.all_senior_collaborators(id).count
      senior_balance = (total_seniors / total_collaborators) * 100 if total_senior.nil?
      senior_deviation = 20 - senior_balance
      senior_deviation.abs
    elsif seniority == "MIDDLE"
      total_middles = TeamBalanceRepository.all_middle_collaborators(id).count
      middle_balance = (total_middles / total_collaborators) * 100 if total_middle.nil?
      middle_deviation = 30 - middle_balance
      middle_deviation.abs
    else
      total_juniors = TeamBalanceRepository.all_junior_collaborators(id).count
      junior_balance = (total_juniors / total_collaborators) * 100 if total_junior.nil?
      junior_deviation = 50 - junior_balance
      junior_deviation.abs
    end
  end

  def calculate_seniority_deviation(junior_deviation, middle_deviation, senior_deviation)
    seniority_deviation = junior_deviation + middle_deviation + senior_deviation
    seniority_deviation
  end

  def calculate_balance(seniority_deviation)
    balance = 100 - seniority_deviation
    balance
  end
end
