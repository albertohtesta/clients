# frozen_string_literal: true

class PostPresenter < ApplicationPresenter
  ATTRS = %i[id collaborator_id title description project_id created_at].freeze
  METHODS = %i[post_url].freeze

  def post_url
    ActiveStorage::Blob.service.path_for(post.key)
  end
end
