# frozen_string_literal: true

class PostPresenter < ApplicationPresenter
  ATTRS = %i[id collaborator_id title description project_id created_at].freeze
  METHODS = [:post_url].freeze

  def post_url
    # TODO: remove url field from post, to properly use ActiveStorage.
    return url unless url.nil?
    post.attached? ? Rails.application.routes.url_helpers.rails_blob_path(post, only_path: true) : nil
  end
end
