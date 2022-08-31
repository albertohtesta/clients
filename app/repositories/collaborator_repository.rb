# frozen_string_literal: true

class CollaboratorRepository < ApplicationRepository
  class << self
    def find_collaborators_by_team_id(team_id)
      scope.includes(:posts, :teams).where(teams: { id: team_id })
    end

    def by_role_name(name)
      scope.includes(:role).where(role: RoleRepository.find_by(name:))
    end

    def find_collaborator_public_profile(collaborator_id)
      scope.includes(:badges).find_by({ id: collaborator_id })
    end

    def collaborators_pool_directory(account_id)
      # TODO: This list of id's is just temporally, will be replaced
      public_profiles_ids = [1, 2, 3, 4, 5, 6, 7, 8, 9, 200, 201, 202, 203]
      scope.select([:id, :profile, :position, :nickname, :uuid]).where({ id: public_profiles_ids }).includes(:accounts).where(accounts: { id: account_id })
    end

    def filter_by_category(account_id, category)
      collaborators_pool_directory(account_id).where({ category: })
    end
  end
end
