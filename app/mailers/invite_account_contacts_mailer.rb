# frozen_string_literal: true

require "http"

class InviteAccountContactsMailer < ApplicationMailer
  class << self
    def invite_to(name:, email:, link:)
      register_path = ENV.fetch("BASE_URL_CLIENTS_CLIENT", "https://qa-clients.nordhen.com/")
      params = {
        subject: "#{name.capitalize}!, Welcome to norden!",
        email:,
        message: "Welcome to norden, click here to finish your register: #{register_path}/client/#{link}"
      }
      ses_api_url = ENV.fetch("SES_API_URL", false)
      if ses_api_url
        request = HTTP.post(ses_api_url, json: params)
        return email if request.status.success?
      end
    end
  end
end
