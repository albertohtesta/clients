# frozen_string_literal: true

class Tool < ApplicationRecord
  validates :name, presence: true
end
