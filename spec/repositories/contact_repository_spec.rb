# frozen_string_literal: true

require "rails_helper"

RSpec.describe ContactRepository do
  describe "repository validations" do
    let(:contact) { create(:contact) }

    it "must return contacts by id and emails" do
      selected_contacts = described_class.contacts_by_account_and_email(contact.account_id, [contact.email])

      expect(selected_contacts).to match_array([contact])
    end

    it "must create invitation for contacts" do
      updated_contacts = described_class.create_invitations_for(contact.account_id, [contact.email])

      expect(updated_contacts).to match_array([contact])
    end
  end
end
