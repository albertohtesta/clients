# frozen_string_literal: true

class Account < ApplicationRecord
  belongs_to :account_status
  belongs_to :manager, class_name: "Collaborator", foreign_key: :manager_id, optional: true

  has_many :projects
  has_many :payments
  has_many :contacts

  validates :account_uuid, :name, presence: true

  alias_attribute :status, :account_status
  before_validation :assign_uuid, on: :create
  before_validation :assign_status_by_default

  def assign_uuid
    self.account_uuid = SecureRandom.uuid unless account_uuid
  end

  def assign_status_by_default
    self.account_status = AccountStatusRepository.new_project_status if account_status.nil?
  end

  def tech_stacks
    AccountRepository.tech_stacks self
  end

  def tools
    AccountRepository.tools self
  end

  def status
    account_status.status
  end

  def location
    city
  end

  def details
    {
      balance:,
      total_projects: projects.count,
      total_teams: projects.map { |project| project.teams.count }.sum
    }
  end

  def finance
    {
      blended_rate:,
      gross_profit:,
      payroll:,
      total_expenses:,
      total_revenue:
    }
  end

  def health
    {
      client_satisfaction:,
      moral:
    }
  end

  def productivity_kpis
    {
      bugs_detected:,
      permanence:,
      productivity:,
      speed:
    }
  end

  def debt?
    payments.each do |payment|
      return true if payment.payment_date.nil? && payment.payday_limit < Time.now
    end
    false
  end

  def payment_status
    debt? ? "Debt" : "On Time"
  end

  def self.import(accounts)
    accounts.map do |item|
      ActiveRecord::Base.transaction do
        account = AccountRepository.first_or_initialize_by_salesforce_id(item[:account][:Id])
        account.update_from_salesforce(item[:account], item[:contacts])
        Contact.update_contacts_from_salesforce(account, item[:contacts])
        Project.update_project_by_salesforce(account, item[:opportunity])
        account.attributes.slice("name", "id", "salesforce_id")
      end
    end
  end

  def update_from_salesforce(client, contacts)
    update({ name: client[:Name], contact_name: contacts.first[:Name],
             contact_email: client[:Email__c], contact_phone: client[:Phone],
             account_web_page: client[:Website], city: client[:ShippingAddress][:city],
             country: client[:ShippingAddress][:country], state: client[:ShippingAddress][:state] })

    update(deleted_at: Time.now) if client[:IsDeleted]
    self
  end
end
