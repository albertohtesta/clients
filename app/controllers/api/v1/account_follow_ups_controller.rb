# frozen_string_literal: true

module Api
  module  V1
    class AccountFollowUpsController < ApplicationController
      def index
        # TODO: Pass current_user with cognito
        @account_follow_ups = AccountFollowUpRepository.by_account_manager(current_user)
        render json: @account_follow_ups, status: :ok
      end

      def create
        @account_follow_ups = AccountFollowUpRepository.new_entity(account_follow_ups_params)

        if @account_follow_ups.save
          render json: @account_follow_ups, status: :created
        else
          render json: @account_follow_ups, status: :unprocessable_entity
        end
      end

      private
        def account_follow_ups_params
          params.require(:account_follow_ups).permit(:follow_date, :account_id)
        end
    end
  end
end
