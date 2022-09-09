# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "Info@nordhen.com"
  layout "mailer"
end
