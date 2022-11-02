# frozen_string_literal: true

class SurveyRepository < ApplicationRepository
  class << self
    PREPARATION = 0
    SENT = 1
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

    def last_closed_survey_of_team(team_id)
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
      scope.where([ "status = :preparation or status = :sent", preparation: PREPARATION, sent: SENT ])
    end

    def team_has_surveys_ongoing?(team_id)
      scope.where([ "team_id = :team_id and (status = :preparation or status = :sent)", 
        team_id: team_id, preparation: PREPARATION, sent: SENT ]).limit(1).length > 0
    end

    def mark_survey_as_sent(id)
      survey = scope.includes(team: :collaborators).find_by_id(id)
      survey.update!(status: :sent, requested_answers: survey.team.collaborators.size)
      survey
    end

    def update_current_answers(id, tf_current_answers)
      survey = scope.find_by_id(id)
      survey.update!(current_answers: tf_current_answers)
      survey
    end
  end
end
