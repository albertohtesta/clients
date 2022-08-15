# frozen_string_literal: true

class SurveyRepository < ApplicationRepository
  class << self
    def surveys_by_team_dates_status(team_id, initial_date, end_date, status)
      scope.where("team_id = :team_id and created_at >= :initial_date and created_at <= :end_date and status = :status",
                  team_id:, initial_date:, end_date:, status:).
                  select(:id, "questions_detail -> 'questions' AS questions")
    end
  end
end
