# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "Contacts Collaborators", type: :request do
  before(:each) do
    create(:account)
  end

  context "Accounts contacts collaborators" do
    let(:Authorization) { @token }

    path "/api/v1/accounts/{account_id}/contacts_collaborators" do
      get "Get all collaborators contact from an acccount" do
        tags "Accounts"

        security [ Bearer: [] ]
        consumes "application/json"
        produces "application/json"
        parameter name: :account_id, in: :path, type: :integer, description: "id of the account"

        response "200", "contacts collaborators found" do
          let(:account_id) { Contact.first.account_id }

          run_test!
        end
      end
    end
  end
  # describe "contacts collaborators" do
  #   it "When the count have contacts" do
  #     @account = create(:account)
  #     @contact = create(:account_contact_collaborator, account: @account)
  #     get api_v1_account_contacts_collaborators_path(account_id: @account.id), headers: { "Authorization" => @token }
  #     expect(response).to have_http_status(200)
  #   end

  #   it "When the count doesnt have contacts" do
  #     get api_v1_account_contacts_collaborators_path(account_id: 1), headers: { "Authorization" => @token }
  #     expect(response).to have_http_status(404)
  #   end
  # end
end
