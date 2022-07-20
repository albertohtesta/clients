# frozen_string_literal: true

class CollaboratorRepository < ApplicationRepository
  def self.find_collaborators_by_project_id(project_id)
    scope.includes(:posts, teams: :projects).where(projects: { id: project_id })
  end
end
