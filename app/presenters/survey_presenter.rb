# frozen_string_literal: true

class SurveyPresenter < ApplicationPresenter
  ATTRS = %i[team_id id status deadline survey_url].freeze
  METHODS = %i[collaborators_count collaborators_info current_responses missing_responses].freeze

  def collaborators_count
    self.team.collaborators.size
  end

  def collaborators_info
    self.team.collaborators.collect { |collaborator| collaborator.slice(:id, :first_name, :last_name) }
  end

  def current_responses
    self.current_answers if self.status != "preparation"
  end

  def missing_responses
    self.requested_answers - self.current_answers if self.status != "preparation"
  end
end
