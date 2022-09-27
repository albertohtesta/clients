# frozen_string_literal: true

class InvestmentRepository < ApplicationRepository
  class << self
    def retrieve_monthly_investments_by_team(team_id, start_date, end_date = Date.today)
      scope
        .where(team_id:)
        .where("date BETWEEN ? AND ?", start_date, end_date)
        .group(Arel.sql("team_id, date_trunc('month',date)"))
        .select("team_id, sum(value) value, date_trunc('month',date) date")
        .order(Arel.sql("date_trunc('month',date)"))
    end
  end
end
