# frozen_string_literal: true

class CollaboratorRepository < ApplicationRepository
  def self.find_collaborators_by_team_id(team_id)
    scope.includes(:posts, :teams).where(teams: { id: team_id })
  end

  def self.find_collaborator_public_profile(collaborator_id)
    scope.includes(:badges).find_by({ id: collaborator_id })
  end

  def self.collaborators_pool_directory
    # TODO: This list of id's is just temporally, will be replaced
    public_profiles_ids = [1, 2, 3, 4, 5, 6, 7]
    scope.select([:id, :first_name, :last_name, :uuid, :position, :profile, :seniority]).where({ id: public_profiles_ids })
  end
end
