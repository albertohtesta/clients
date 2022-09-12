# frozen_string_literal: true
# # frozen_string_literal: true

# require "test_helper"

# class Api::V1::Public::CollaboratorsControllerTest < ActionDispatch::IntegrationTest
#   setup do
#     stub_cognito_uri
#     @collaborator = create(:collaborator)
#   end

#   test "should show api_v1_public_collaborator info" do
#     get api_v1_public_collaborator_path(@collaborator.id), headers: { "Authorization" => @token }

#     assert_response :success
#   end

#   test "should get not found when collaborator not exist" do
#     get api_v1_public_collaborator_url(0), headers: { "Authorization" => @token }

#     assert_response :not_found
#   end
# end
