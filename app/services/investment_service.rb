# frozen_string_literal: true

class InvestmentService < ApplicationService
  class << self
    def investments_by_team_for_period(team_id, period)
      current_date = Time.now.to_date
      start_date = current_date.at_beginning_of_year
      case period.to_sym
      when :monthly then
        end_date = (Time.now - 1.month).to_date.at_end_of_month
        return [] if end_date < start_date
      when :quarter then
        end_date = current_date
      else
        return []
      end
      InvestmentRepository.retrieve_monthly_investments_by_team(team_id, start_date, end_date).to_a
    end
  end
end
