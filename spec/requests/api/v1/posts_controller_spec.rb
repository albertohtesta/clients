# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "PostController", type: :request do
  include_context "login_user"

  context "Posts" do
    let(:post) { create(:post) }
    let(:id) { post.id }

    path "/api/v1/posts/{id}" do
      get "Get a post of a collaborator" do
        tags "Posts"
        security [ Bearer: [] ]
        consumes "application/json"
        produces "application/json"
        parameter name: :id, in: :path, type: :integer, description: "post id"

        response "200", "posts found" do
          run_test!
        end
      end
    end
  end
end
