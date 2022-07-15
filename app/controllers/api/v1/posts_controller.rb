# frozen_string_literal: true

module Api
  module  V1
    class PostsController < ApplicationController
      before_action :set_collaborators_post, only: %i[show]

      def show
        if @post
          render json: PostPresenter.new(@post).json
        else
          render json: {}, status: :not_found
        end
      end

      private
        def set_collaborators_post
          @post = PostRepository.find_by(id: params[:id])
        end
    end
  end
end
