# frozen_string_literal: true

class CollaboratorsTeam < ApplicationRecord
  belongs_to :collaborator
  belongs_to :team
end
