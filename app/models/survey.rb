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

  validate :deadline_date_cannot_be_in_the_past, on: :create, unless: -> { deadline.blank? }
  validate :no_survey_ongoing, on: :create, unless: -> { self.closed? }
  before_validation :set_defaults

  before_create do
    get_survey_url unless self.survey_url.present?
  end

  def no_survey_ongoing
    errors.add(:status, :blank, message: 
      "There is a survey ongoing for this team") unless !SurveyRepository.team_has_surveys_ongoing?(team_id)
  end

  def deadline_date_cannot_be_in_the_past
    if self.deadline < Date.today && !self.closed?
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
      self.current_answers ||= 0
      self.requested_answers ||= 0
      self.status ||= "preparation"
      self.started_at = SurveyCreateService.calculate_started_at(self.period, self.period_value, self.year)
    end

    def get_survey_url
      survey_remote_data = SurveyCreateService.get_survey_remote_data(self.description, self.survey_url)
      self.survey_url = survey_remote_data[:survey_url]
      self.remote_survey_id = survey_remote_data[:remote_survey_id]
    end
end
