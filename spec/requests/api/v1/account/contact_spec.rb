# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "Contacts", type: :request do
  describe "GET contacts" do
    it "should not return all the contacts for an account" do
      account = create(:account)
      get api_v1_account_contacts_path(account_id: account.id)
      expect(response).to have_http_status(404)
    end
  end
end
