# frozen_string_literal: true

class CollaboratorsBadge < ApplicationRecord
  belongs_to :collaborator
  belongs_to :badge
end
