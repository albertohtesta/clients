# frozen_string_literal: true

class CollaboratorPresenter < ApplicationPresenter
  ATTRS = %i[id first_name last_name role]
  METHODS = %i[post]
  ASSOCIATIONS = []

  private
    def post
      return PostPresenter.new(posts.last).json if !posts.last.nil?

      []
    end
end
