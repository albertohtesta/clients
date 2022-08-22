# frozen_string_literal: true

class StatusPresenter < ApplicationPresenter
  ATTRS = %i[team_id id status deadline].freeze
  METHODS = %i[collaborators_count collaborators_info current_responses missing_responses].freeze

  def collaborators_count
    self.team.collaborators.count
  end

  def collaborators_info
    self.team.collaborators.select("id", "first_name", "last_name")
  end

  def current_responses
    self.current_answers unless self.status == "preparation"
  end

  def missing_responses
    self.requested_answers - self.current_answers unless self.status == "preparation"
  end
end
