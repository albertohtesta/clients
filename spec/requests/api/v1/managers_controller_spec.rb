# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "Managers", type: :request do
  include_context "login_user"

  let(:collaborator) { create(:collaborator, :manager) }
  let(:id) { collaborator.id }

  path "/api/v1/managers/{id}" do
    get "show information of a manager" do
      tags "Managers"
      security [ Bearer: [] ]
      consumes "application/json"
      produces "application/json"
      parameter name: :Authorization, in: :headers, type: :string, description: "autorizartion token with the user info"
      parameter name: :id, in: :path, type: :integer, description: "id of the manager collaborator"

      response(200, "managers show") do
        run_test!
      end

      response(404, "managers not found error") do
        let(:id) { 0 }
        run_test!
      end
    end
  end
end
