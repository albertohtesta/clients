# frozen_string_literal: true

class Survey < ApplicationRecord
  belongs_to :team
  enum status: %i[preparation sent closed]
  enum period: %i[month quarter year]

  validates :team_id, presence: true
  validates :deadline, presence: true
  validates :period, presence: true
  validates :status, presence: true
  validates_inclusion_of :period, in: periods
  validates_inclusion_of :status, in: statuses

  validates :status, uniqueness: { scope: :team_id, message: "There is a survey ongoing for this team.", conditions: -> { where.not(status: "closed") } }
  validate :deadline_date_cannot_be_in_the_past, unless: -> { deadline.blank? }

  before_validation :set_defaults

  before_create do
    get_survey_url unless self.survey_url.present?
  end

  def deadline_date_cannot_be_in_the_past
    if deadline < Date.today && status != "closed"
      errors.add(:deadline, :blank, message: "can't be in the past.")
    end
  end

  def period=(value)
    super
  rescue ArgumentError
    @attributes.write_cast_value("period", value)
  end

  def status=(value)
    super
  rescue ArgumentError
    @attributes.write_cast_value("status", value)
  end

  private
    def set_defaults
      self.current_answers = 0 if current_answers.blank?
      self.requested_answers = 0 if requested_answers.blank?
    end

    def get_survey_url
      survey_remote_data = SurveyCreateService.get_survey_remote_data(self.description, self.survey_url)
      self.survey_url = survey_remote_data[:survey_url]
      self.remote_survey_id = survey_remote_data[:remote_survey_id]
    end
end
