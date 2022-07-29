# frozen_string_literal: true

class InvestmentRepository < ApplicationRepository
  class << self
    def retrieve_current_year_investments_by_team_id(team_id)
      scope.where(team_id:)
        .where("date BETWEEN ? AND ?", Date.current.beginning_of_year, Date.current.end_of_year)
        .order(date: :asc)
        .all
    end
  end
end
