# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :account
  validates :name, :start_date, presence: true
end
