# frozen_string_literal: true

module Api
  module  V1
    class ManagersController < ApplicationController
      before_action :retrieve_manager

      def show
        if @manager
          render json: ManagerPresenter.new(@manager).json
        else
          render json: { error: "Manager not found" }, status: :not_found
        end
      end

      private
        def retrieve_manager
          @manager = ManagerRepository.with_accounts_by_id(params[:id])
        end
    end
  end
end
