# frozen_string_literal: true

class TeamType < ApplicationRecord
  validates :name, presence: true
end
