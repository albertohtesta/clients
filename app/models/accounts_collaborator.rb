# frozen_string_literal: true

class AccountsCollaborator < ApplicationRecord
  belongs_to :collaborator
  belongs_to :account

  enum :status, { available: 1 }
end
