# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "#teams", type: :request do
  context "when visit accounts and have theirs teams" do
    let(:Authorization) { @token }

    path "/api/v1/accounts/{account_id}/teams" do
      get "account_teams" do
        tags "Account metric"

        security [ Bearer: [] ]
        consumes "application/json"
        produces "application/json"
        parameter name: :account_id,
          in: :path,
          type: :string,
          description: "",
          required: false

        response "200", "find teams by account" do
          let(:account) { create(:account, city: "city") }
          let!(:project) { create(:project, account:) }
          let(:team) { create(:team, project:) }
          let!(:team_balance) { create(:team_balance, team_id: team.id, account_id: account.id) }
          let!(:account_id) { account.id }

          run_test!
        end

        response "404", "find metric historial" do
          let(:account_id) { nil }

          run_test!
        end
      end
    end
  end
end
