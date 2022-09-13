# frozen_string_literal: true
# # frozen_string_literal: true

# require "test_helper"

# class Api::V1::PostsControllerTest < ActionDispatch::IntegrationTest
#   setup do
#     stub_cognito_uri
#   end

  # test "should get success response" do
  #   test_post = create_fake_post

  #   get api_v1_post_path(id: test_post.id), headers: { "Authorization" => @token }

  #   assert_response :success
  # end

  # test "should get 'post not found' error" do
  #   get api_v1_post_path(id: 0), headers: { "Authorization" => @token }

  #   assert_response :not_found
  # end

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
