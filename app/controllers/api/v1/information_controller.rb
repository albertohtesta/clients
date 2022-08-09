# frozen_string_literal: true

# ***************************
# IMPORTANT
# ***************************
# TODO: DELETE THIS ENDPOINT IT'S JUST TEMPORALLY TO KNOW THE DATABASE INFORMATION IN QA

module Api
  module V1
    class InformationController < ApplicationController
      def index
        accounts = AccountRepository.all
        database_information = accounts.map do |account|
          account.attributes.merge({
            teams: account.projects.map(&:teams).flatten,
            metrics: account.metrics
          })
        end

        render json: database_information
      end
    end
  end
end
