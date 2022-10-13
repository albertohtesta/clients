# frozen_string_literal: true

require "rails_helper"

RSpec.describe ContactRepository do
  describe "repository validations" do
    let(:contact) { create(:contact) }

    it "must return contacts by account id" do
      selected_contacts = described_class.contacts_by_account(contact.account_id)

      expect(selected_contacts).to match_array([contact])
    end

    it "must return contacts by account_id and email" do
      exist_contact = { email: contact.email, first_name: contact.first_name, last_name: contact.last_name }
      selected_contacts = described_class.create_or_get_contacts_by_account(contact.account_id, [exist_contact])

      expect(selected_contacts).to match_array([contact[:email]])
    end

    it "must create a contact related with account" do
      new_contact = { email: "fake@gmail.com", first_name: "first_name", last_name: "last_name" }
      selected_contacts = described_class.create_or_get_contacts_by_account(contact.account_id, [new_contact])

      expect(selected_contacts).to match_array([new_contact[:email]])
      expect(Contact.where({ email: "fake@gmail.com" }).count).to eq(1)
    end

    it "must create invitation for contacts" do
      described_class.create_invitations_for(contact.account_id, [contact.email])

      expect(Contact.first[:invite_status]).to eql("invited")
      expect(Contact.first[:invite_date]).to eql(Date.today)
    end

    it "must assing uuid and status for an invited contact" do
      described_class.assign_uuid_and_status_to_contact(contact.email, "123456")

      expect(Contact.first[:uuid]).to eql("123456")
      expect(Contact.first[:invite_status]).to eql("confirmed")
    end
  end
end
