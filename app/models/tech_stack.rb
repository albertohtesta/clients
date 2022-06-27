# frozen_string_literal: true

class TechStack < ApplicationRecord
  validates :name, presence: true
end
