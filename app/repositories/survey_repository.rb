# frozen_string_literal: true

class SurveyRepository < ApplicationRepository
  class << self
    def find_by_id(id)
      scope.includes(:team).find_by({ id: })
    end

    def surveys_by_team_dates_status(team_id, initial_date, end_date, status)
      scope.where({ team_id:, status:, created_at: initial_date..end_date }).select(:id, "questions_detail -> 'questions' AS questions")
    end
  end
end
