# frozen_string_literal: true

require "swagger_helper"

describe "Accounts", type: :request do
  include_context "login_user"

  before do
    account = create(:account)
    project = create(:project, account:)
    create(:team, project:)
    create(:contact, account:)
  end

  context "invite_accounts_contacts" do
    let(:contact) { Contact.first }
    let(:account_id) { contact.account_id }

    path "/api/v1/accounts/{account_id}/invitations" do
      post "Invite account contacts throght email" do
        tags "Accounts"

        security [ Bearer: [] ]
        consumes "application/json"
        produces "application/json"
        parameter name: :account_id, in: :path, type: :integer, description: "id of the account"
        parameter name: :contacts, in: :body, type: :array, description: "array of emails of the contacts to invite should contain [email, first_name, last_name]"


        response "200", "contacts invited when contact exist" do
          let(:contacts) { { contacts: [{ email: contact.email, first_name: contact.first_name, last_name: contact.last_name }] } }

          run_test!
        end

        response "200", "contacts invited when the contacts is not registered" do
          let(:contacts) { { contacts: [{ email: "fakeemail@gmail.com", first_name: "fake_name", last_name: "fake_last_name" }] } }

          run_test! do |response|
            expect(Contact.where({ email: "fakeemail@gmail.com" }).count).to eq(1)
          end
        end
      end
    end
  end
end
