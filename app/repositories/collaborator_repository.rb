# frozen_string_literal: true

class CollaboratorRepository < ApplicationRepository
  def self.find_collaborators_by_team_id(team_id)
    scope.includes(:posts, teams: :project).where(teams: { id: team_id })
  end

  def self.account_managers
    scope.includes(:role).where(role: RoleRepository.find_by(name: "Account Manager"))
  end

  def self.developers
    scope.includes(:role).where(role: RoleRepository.find_by(name: "Developer"))
  end
end
