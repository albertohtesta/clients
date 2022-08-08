# frozen_string_literal: true

# ***************************
# IMPORTANT
# ***************************
# TODO: DELETE THIS ENDPOINT IT'S JUST TEMPORALLY TO KNOW THE DATABASE INFORMATION IN QA

module Api
  module V1
    class InformationController < ApplicationController
      def index
        accounts = Account.all
        database_information = accounts.map do |account|
          account.attributes.merge({
            contacts: account.contacts,
            collaborators_contacts: account.account_contact_collaborators,
            projects: account.projects,
            teams: account.projects.map(&:teams).flatten,
            collaborators: account.projects.map(&:teams).flatten.map(&:collaborators),
            metrics: account.metrics
          })
        end

        render json: database_information
      end
    end
  end
end
