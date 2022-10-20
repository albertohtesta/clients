# frozen_string_literal: true

class InvestmentRepository < ApplicationRepository
  class << self
    def retrieve_monthly_investments_by_team(team_id, start_date, end_date = Date.today)
      scope
        .where(team_id:)
        .where("date BETWEEN ? AND ?", start_date, end_date)
        .group(Arel.sql("team_id, date_trunc('month',date)"))
        .select("team_id, sum(value) as value, date_trunc('month',date) as date")
        .order(Arel.sql("date_trunc('month',date)"))
    end
    def find_years_by_team(team_id)
      scope
        .distinct.select("date_trunc('year',date) as trunc")
        .where(team_id:)
        .map { |rel| rel.trunc.year }
        .to_a
        .sort
    end
  end
end
