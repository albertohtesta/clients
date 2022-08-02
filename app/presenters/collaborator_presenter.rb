# frozen_string_literal: true

class CollaboratorPresenter < ApplicationPresenter
  ATTRS = %i[id position]
  METHODS = %i[name posts_count img post]
  ASSOCIATIONS = []

  private
    def post
      return PostPresenter.new(posts.last).json if !posts.last.nil?

      []
    end

    def name
      "#{first_name} #{last_name}"
    end

    def posts_count
      posts.size
    end

    def img
      # TODO return user image
      ""
    end
end
