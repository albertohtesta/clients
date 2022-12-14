# frozen_string_literal: true

class CollaboratorRepository < ApplicationRepository
  class << self
    def find_collaborators_by_team_id(team_id)
      scope.includes(:posts, :teams).where(teams: { id: team_id })
    end

    def change_collaborator_from_account(collaborator_team_ids, collaborator_id)
      ActiveRecord::Base.transaction do
        # To Do: this id is just temporal we need to add name to team table
        CollaboratorsTeam.where(id: collaborator_team_ids).each(&:destroy!)
        CollaboratorsTeam.create!(team_id: Team::UNDEFINED_TEAM, collaborator_id:)
      end
    end

    def collaborators_by_account(account)
      scope.includes(:teams).where({
        teams: { id: account.teams.ids }
      })
    end

    def collaborators_number_by_account(account)
      scope.includes(:teams).where({
        teams: { id: account.teams.ids }
      }).size
    end

    def by_role_name(name)
      scope.includes(:role).where(role: RoleRepository.find_by(name:))
    end

    def find_collaborator_public_profile(collaborator_id)
      scope.includes(:badges).find_by({ id: collaborator_id })
    end

    def collaborators_pool_directory(account_id, category)
      public_profiles_ids = scope
                              .includes(:accounts_collaborators)
                              .where(accounts: { id: account_id })
                              .select(:collaborator_id)
      talent_pool = scope
                      .includes(:accounts)
                      .where(accounts: { id: account_id })
                      .select(:id, :first_name, :last_name, :profile, :position, :nickname, :uuid)
                      .where(id: public_profiles_ids)

      return talent_pool.where(category:) unless category.blank?

      talent_pool
    end
  end
end
