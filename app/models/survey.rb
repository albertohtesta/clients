# frozen_string_literal: true

class Survey < ApplicationRecord
  belongs_to :team
  enum status: %i[preparation sent closed]
  enum period: %i[month quarter]

  validates :team_id, presence: true
  validates :deadline, presence: true
  validates :period, presence: true
  validates :status, presence: true

  validate :deadline_date_cannot_be_in_the_past

  def deadline_date_cannot_be_in_the_past
    if deadline < Date.today && status != "closed"
      errors.add(:expiration_date, :blank, "can't be in the past")
    end
  end
end
