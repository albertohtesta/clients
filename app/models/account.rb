# frozen_string_literal: true

class Account < ApplicationRecord
  belongs_to :account_status
  belongs_to :manager, class_name: "Collaborator", foreign_key: :manager_id, optional: true

  has_many :projects
  has_many :payments
  has_many :contacts
  has_many :metrics, as: :related
  has_many :team_requirements
  has_many :account_contact_collaborators
  has_many :account_follow_ups, -> { order("follow_date ASC") }
  has_many :team_balances
  has_and_belongs_to_many :collaborators

  validates :account_uuid, :name, presence: true

  alias_attribute :status, :account_status
  before_validation :assign_uuid, on: :create
  before_validation :assign_status_by_default

  def tech_stacks
    projects.map { |project| project.tech_stacks.pluck(:name) }.flatten.uniq
  end

  def debt?
    payments.each do |payment|
      return true if payment.payment_date.nil? && payment.payday_limit < Time.now
    end
    false
  end

  def tools
    projects.map { |project| project.tools.pluck(:name) }.flatten.uniq
  end

  def status
    account_status.status
  end

  def last_follow_up
    account_follow_ups.blank? ? nil : account_follow_ups.last
  end

  def last_metric_follow_up_date
    metrics.blank? ? nil : metrics.order("date DESC").first["date"]
  end

  def assign_uuid
    self.account_uuid = SecureRandom.uuid unless account_uuid
  end

  def assign_status_by_default
    self.account_status = AccountStatusRepository.find_by(status_code: :new_project) if account_status.nil?
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
