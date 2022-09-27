# frozen_string_literal: true

class AccountsCollaborator < ApplicationRecord
  belongs_to :collaborator
  belongs_to :account

  enum :status, { unavailable: 0, available: 1 }
end
