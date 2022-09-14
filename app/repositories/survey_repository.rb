# frozen_string_literal: true

class SurveyRepository < ApplicationRepository
  class << self
    def find_by_id(id)
      scope.includes(team: :collaborators).find_by_id(id)
    end

    def surveys_by_team_dates_status(**args)
      scope.where({ team_id: args[:team_id],
        status: args[:status],
        started_at: args[:initial_date]..args[:end_date] }).
        select(:id, "questions_detail -> 'questions' AS questions")
    end
  end
end
