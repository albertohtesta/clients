# frozen_string_literal: true

require "swagger_helper"

describe "Accounts", type: :request do
  let(:Authorization) { @token }

  before do
    contact = build(:contact, :user)
    contact.save
    login_as(contact)
    account = create(:account)
    project = create(:project, account:)
    create(:team, project:)
    create(:contact, account:)
  end

  context "invite_accounts_contacts" do
    let(:Authorization) { @token }
    let(:contact) { Contact.first }
    let(:account_id) { contact.account_id }
    let(:emails) { { emails: [contact.email] } }

    path "/api/v1/accounts/{account_id}/invitations" do
      post "Invite account contacts throght email" do
        tags "Accounts"

        security [ Bearer: [] ]
        consumes "application/json"
        produces "application/json"
        parameter name: :account_id, in: :path, type: :integer, description: "id of the account"
        parameter name: :emails, in: :body, type: :array, description: "array of emails of the contacts to invite"


        response "200", "contacts invited" do
          run_test!
        end
      end
    end
  end
end
