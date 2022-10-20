# frozen_string_literal: true

class InvestmentService < ApplicationService
  class << self
    def investments_by_team_for_period(team_id, period, year = Time.now.year)
      year = year.to_i == 0 ? Time.now.year : year.to_i
      start_date = Date.new(year)
      end_date = end_date_for_period(period, year)
      return [] if end_date.nil?

      InvestmentRepository.retrieve_monthly_investments_by_team(team_id, start_date, end_date).to_a
    end

    def years_for_a_team(team_id)
      throw ArgumentError.new("team_id is required") unless team_id

      InvestmentRepository.find_years_by_team(team_id).reverse
    end

    private
      def end_date_for_period(period, year)
        return Date.new(year).end_of_year if year < Time.now.year

        case period.to_sym
        when :monthly then
          end_date = (Time.now - 1.month).to_date.at_end_of_month
          return end_date if end_date.year == year

        when :quarter then
          Time.now.to_date
        end
      end
  end
end
