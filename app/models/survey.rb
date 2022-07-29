# frozen_string_literal: true

class Survey < ApplicationRecord
  belongs_to :team
  enum status: %i[open closed]
  enum period: %i[month quarter year]
end
