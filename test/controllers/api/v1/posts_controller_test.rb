# frozen_string_literal: true

require "test_helper"

module Api
  module V1
    class PostsControllerTest < ActionDispatch::IntegrationTest
      test "should get success response" do
        test_post = create_fake_post
        get api_v1_collaborator_post_path(collaborator_id: test_post.collaborator_id, id: test_post.id)
        res = JSON.parse(@response.body)

        assert_response :success
        assert res.keys.include?("post_url")
      end

      test "should get 'post not found' error" do
        get api_v1_collaborator_post_path(:collaborator, id: 0)

        assert_response :not_found
      end

      private

      def create_fake_post
        test_post = create(:post)
        test_post.post.attach(
          io: File.open(Rails.root.join("test/fixtures/files/example.png")),
          filename: "example.png"
        )
        test_post
      end
    end
  end
end
