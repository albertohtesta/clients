# frozen_string_literal: true

class InvestmentRepository < ApplicationRepository
  class << self
    def retrieve_previous_months_by_team(team_id, start_date, end_date = Date.today)
      scope.where(team_id:)
        .where("date BETWEEN ? AND ?", start_date, end_date)
        .order(date: :asc)
    end
  end
end
