# frozen_string_literal: true

class AccountContactCollaborator < ApplicationRecord
  validates :collaborator_id, uniqueness: true
  validates :account_id, uniqueness: true

  belongs_to :account
  belongs_to :collaborator
end
