# frozen_string_literal: true

class Contact < ApplicationRecord
  belongs_to :account
  enum invite_status: { invited: "invited", confirmed: "confirmed" }
  validates :first_name, :email, :last_name, presence: true

  def self.update_contacts_from_salesforce(account, remote_contacts)
    remote_contacts.each do |remote_contact|
      contact = account.contacts.where(salesforce_id: remote_contact[:Id]).first_or_initialize
      contact.update({
                       email: remote_contact[:Email],
                       first_name: remote_contact[:FirstName],
                       last_name: remote_contact[:LastName],
                       phone: remote_contact[:Phone]
                     })

      contact.update(deleted_at: Time.now) if remote_contact[:IsDeleted]
    end
  end
end
