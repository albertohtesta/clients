# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "TeamsCollaborators", type: :request do
  include_context "login_user"

  let(:collaborators_team) { create(:collaborators_team) }
  let(:team_id) { collaborators_team.team_id }

  path "/api/v1/teams/{team_id}/collaborators" do
    get "list collaborators by team" do
      tags "Teams"
      security [ Bearer: [] ]
      consumes "application/json"
      produces "application/json"
      parameter name: :Authorization, in: :headers, type: :string, description: "autorizartion token with the user info"
      parameter name: :team_id, in: :path, type: :integer, description: "team id"

      response(200, "teams collaborators index") do
        run_test!
      end
    end
  end
end
