# frozen_string_literal: true

class AccountCollaborator < ApplicationRecord
  belongs_to :account
  belongs_to :collaborator
end
