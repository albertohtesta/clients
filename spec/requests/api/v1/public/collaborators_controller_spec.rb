# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "/api/v1/public/collaborators", type: :request do
  context "Collaborators" do
    let(:Authorization) { @token }

    path "/api/v1/public/collaborators" do
      get "Get talent pool directory" do
        tags "Collaborators"

        security [ Bearer: [] ]
        consumes "application/json"
        produces "application/json"

        response "200", "talent pool directory found" do
          collaborator_ids = [1, 2, 3, 4, 5, 6, 7, 200, 201, 202, 203]
          collaborator_ids.map do |id|
            let!(:"collaborator#{id}") { create(:collaborator, id:) }
          end

          run_test!
        end

        response "404", "talent pool directory not found" do
          run_test!
        end
      end
    end

    path "/api/v1/public/collaborators" do
      get "Get talent pool directory" do
        tags "Collaborators"

        security [ Bearer: [] ]
        consumes "application/json"
        produces "application/json"
        parameter name: :category, in: :query, type: :string, description: "filter by category", required: false, allowReserved: true

        response "200", "talent pool directory filtered found" do
          collaborator_ids = [1, 2, 3, 4, 5, 6, 7, 200, 201, 202, 203]
          collaborator_ids.map do |id|
            let!(:"collaborator#{id}") { create(:collaborator, id:) }
          end

          let!(:category) { "DEVELOPER" }
          run_test!
        end
      end
    end
  end
end
