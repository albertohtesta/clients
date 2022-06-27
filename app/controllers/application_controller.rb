# frozen_string_literal: true

class ApplicationController < ActionController::API
  def current_user
    Collaborator.first
  end
end
