# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "/api/v1/metrics", type: :request do
  let(:Authorization) { @token }

  before do
    contact = build(:contact, :user)
    contact.save
    login_as(contact)
    team = create(:team)
    create(:metric, related: team)
  end

  context "Metric" do
    let(:Authorization) { @token }
    let(:team) { Team.first }
    let(:group_by) { "monthly" }
    let(:indicator_type) {  "performance" }

    path "/api/v1/metrics" do
      get "Get metrics of team" do
        tags "Metrics"
        security [ Bearer: [] ]
        consumes "application/json"
        produces "application/json"
        parameter name: :group_by, in: :query, type: :string, description: "[quarters, monthly]"
        parameter name: :team_id, in: :query, type: :integer, description: "team id"
        parameter name: :indicator_type, in: :query, type: :string, description: "['balance', 'velocity', 'morale', 'performance']"

        response "200", "metrics found" do
          let(:team_id) {  team.id }

          run_test!
        end

        response "404", "Not metrics found" do
          let(:team_id) { 0 }

          run_test!
        end
      end
    end
  end
end
