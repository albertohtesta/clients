# frozen_string_literal: true

module Api
  module V1
    module Public
      class CollaboratorsController < ApplicationController
        before_action :set_public_collaborator_profile, only: :show

        def index
          pool_directory = talent_pool_directory

          return render(json: { message: "No pool directory found" }, status: :not_found) if pool_directory.empty?

          if params[:category].present?
            pool_directory = pool_directory.where("collaborators.category LIKE ?", params[:category])
          else
            pool_directory
          end

          render json: pool_directory, status: :ok
        end

        def show
          if @collaborator
            render json: ::Public::CollaboratorPresenter.new(@collaborator).json, status: :ok
          else
            render json: { message: "No collaborator found" }, status: :not_found
          end
        end

        private
          def set_public_collaborator_profile
            @collaborator = CollaboratorRepository.find_collaborator_public_profile(params[:id])
          end

          def talent_pool_directory
            CollaboratorRepository.collaborators_pool_directory(params[:account_id], params[:category])
          end
      end
    end
  end
end
