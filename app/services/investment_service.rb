# frozen_string_literal: true

class InvestmentService < ApplicationService
  class << self
    def investments_by_team_for_period(team_id, period)
      case period.to_sym
      when :months then
        date = (Time.now - 1.month).to_date
        start_date = date.at_beginning_of_month
        end_date = date.at_end_of_month
      when :quarters then
        start_date = Time.now.to_date.at_beginning_of_quarter
        end_date = Time.now.to_date
      else
        return nil
      end
      InvestmentRepository.retrieve_previous_months_by_team(team_id, start_date, end_date)
    end
  end
end
