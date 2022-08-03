# frozen_string_literal: true

class AccountContactCollaborator < ApplicationRecord
  belongs_to :account
  belongs_to :collaborator
end
