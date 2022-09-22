# frozen_string_literal: true

class AccountInfoPresenter < ApplicationPresenter
  ATTRS = %i[id account_uuid name account_web_page logo display_brand].freeze
  METHODS = %i[projects_ids teams_ids].freeze

  def projects_ids
    ProjectRepository.find_projects_ids_of_account(id)
  end

  def teams_ids
    TeamRepository.find_teams_ids_of_project(projects_ids)
  end
end
