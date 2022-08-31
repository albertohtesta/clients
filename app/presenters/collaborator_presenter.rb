# frozen_string_literal: true

class CollaboratorPresenter < ApplicationPresenter
  ATTRS = %i[id uuid position]
  METHODS = %i[name posts_count img post]
  ASSOCIATIONS = []

  private
    def post
      return [] if posts.last.nil?

      PostPresenter.new(posts.last).json
    end

    def name
      "#{first_name} #{last_name}"
    end

    def posts_count
      posts.size
    end

    def img
      profile
      # avatar.attached? ? Rails.application.routes.url_helpers.rails_blob_path(avatar, only_path: true) : nil
    end
end
