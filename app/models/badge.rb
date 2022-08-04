# frozen_string_literal: true

class Badge < ApplicationRecord
  has_many :collaborators_badges
  has_many :collaborators, through: :collaborators_badges

  validates :name, presence: true
end
