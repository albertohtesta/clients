# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "Contacts Collaborators", type: :request do
  describe "contacts collaborators" do
    it "When the count have contacts" do
      @account = create(:account)
      @contact = create(:account_contact_collaborator, account: @account)
      get api_v1_account_contacts_collaborators_path(account_id: @account.id), headers: { "Authorization" => @token }
      expect(response).to have_http_status(200)
    end

    it "When the count doesnt have contacts" do
      get api_v1_account_contacts_collaborators_path(account_id: 1), headers: { "Authorization" => @token }
      expect(response).to have_http_status(404)
    end
  end
end
