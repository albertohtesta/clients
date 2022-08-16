# frozen_string_literal: true

class SurveyPresenter < ApplicationPresenter
  ATTRS = %i[team_id id team_collaborators_count].freeze
  METHODS = [:members_count].freeze

  def members_count
    __getobj__.team.collaborators.count
  end
end
