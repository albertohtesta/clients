# frozen_string_literal: true

class SurveyRepository < ApplicationRepository
  class << self
    CLOSED = 2
    def find_by_id(id)
      scope.includes(team: :collaborators).find_by_id(id)
    end

    def surveys_by_team_dates_status(**args)
      scope.where({ team_id: args[:team_id],
        status: args[:status],
        started_at: args[:initial_date]..args[:end_date] }).
        select(:id, "questions_detail -> 'questions' AS questions")
    end

    def last_survey_of_team(team_id)
      scope.where(["team_id = :team_id and status = :status", team_id:, status: CLOSED])
      .select(:id, "questions_detail -> 'questions' AS questions").last
    end

    def update_survey_responses(survey_id, num_of_answers)
      survey = scope.find_by_id(survey_id)
      return unless survey
      unless survey.update(current_answers: num_of_answers)
        logger = Logger.new(STDOUT)
        logger.info("Survey: #{survey.id} current answers could not be updated")
      end
    end

    def surveys_ongoing
      scope.where({ status: !CLOSED })
    end
  end
end
