# frozen_string_literal: true

class PostPresenter < ApplicationPresenter
  ATTRS = %i[id collaborator_id title description project_id created_at].freeze

  def post_url
    post.attached? ? post.url : nil
  end
end
