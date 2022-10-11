# frozen_string_literal: true

require "rails_helper"

RSpec.describe ContactRepository do
  describe "repository validations" do
    let(:contact) { create(:contact) }

    it "must return contacts by account id" do
      selected_contacts = described_class.contacts_by_account(contact.account_id)

      expect(selected_contacts).to match_array([contact])
    end

    it "must return contacts by account_id and emails" do
      selected_contacts = described_class.contacts_by_account_and_email(contact.account_id, [contact.email])

      expect(selected_contacts.first.email).to eql(contact.email)
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
