# frozen_string_literal: true

class Survey < ApplicationRecord
  belongs_to :team
  enum status: %i[preparation sent closed]
  enum period: %i[month quarter]

  validates :team_id, presence: true
  validates :deadline, presence: true
  validates :period, presence: true
  validates :status, presence: true
  # WIP inlcusions, not working as spected yet
  validates :period, inclusion: { in: periods }
  validates :status, inclusion: { in: statuses }

  validates :status, uniqueness: { scope: :team_id, message: "There is a sourvey ongoing for this team.", conditions: -> { where.not(status: "closed") } }
  validate :deadline_date_cannot_be_in_the_past, unless: -> { deadline.blank? }

  def deadline_date_cannot_be_in_the_past
    if deadline < Date.today && status != "closed"
      errors.add(:deadline, :blank, message: "can't be in the past.")
    end
  end
end
