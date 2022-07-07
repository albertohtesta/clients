# frozen_string_literal: true

module Api
  module  V1
    class PostsController < ApplicationController
      before_action :set_collaborators_post, only: %i[show]

      def show
        if @collaborator_post
          render json: PostPresenter.new(@collaborator_post).json
        else
          render json: {}, status: :not_found
        end
      end

      private

      def set_collaborators_post
        @collaborator_post = PostRepository.find_by(
          { collaborator_id: params[:collaborator_id], id: params[:id] }
        )
      end
    end
  end
end
