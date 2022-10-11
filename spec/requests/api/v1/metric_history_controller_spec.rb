# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "#metric_historial", type: :request do
  include_context "login_user"

  context "when user visit metric_history" do
    path "/api/v1/metric_history/{id}" do
      get "metric_history" do
        tags "MetricHistory"

        security [ Bearer: [] ]
        consumes "application/json"
        produces "application/json"
        parameter name: :id, in: :path, type: :string, description: "filter by category", required: false
        parameter name: :Authorization, in: :headers, type: :string, description: "autorizartion token with the user info"


        response "200", "find metric historial" do
          let!(:account) { create(:account, city: "city") }
          let!(:metric_follow_up) { create(:metric_follow_up, account:) }
          let!(:metric_historial) { create(:metric_history, metric_follow_up:) }
          let(:id) { metric_follow_up.id }

          run_test!
        end

        response "404", "find metric historial" do
          let(:id) { 1 }

          run_test!
        end
      end

      put "update metric" do
        tags "metric"
        security [ Bearer: [] ]
        consumes "application/json"
        produces "application/json"
        parameter name: :id, in: :path
        parameter name: :account_id, in: :body
        parameter name: :Authorization, in: :headers, type: :string, description: "autorizartion token with the user info"

        response(200, "successful") do
          let!(:manager) { create(:collaborator) }
          let!(:account) { create(:account, manager:, city: "LA") }
          let!(:metric) { create(:metric, related: account) }
          let!(:account_id) { account.id  }
          let(:id) { metric.id }
          run_test!
        end
      end
    end
  end
end
