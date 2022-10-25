# frozen_string_literal: true

class CollaboratorToAccountService < ApplicationService
  def initialize(account:, collaborator_id:)
    @account = account
    @collaborator_id = collaborator_id
  end

  def retrive_collaborator_team_ids
    CollaboratorsTeam.where(team: retrive_teams, collaborator_id:).pluck(:id)
  end

  private
    attr_reader :account, :collaborator_id

    def retrive_teams
      Team.where(project: account.projects)
    end
end
