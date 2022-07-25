# frozen_string_literal: true

class Metric < ApplicationRecord
  belongs_to :team
  validates :date, :metrics, :indicator_type, presence: true

  enum indicator_type: { performance: "performance", velocity: "velocity", morale: "morale", balance: "balance" }
end
