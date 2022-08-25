# frozen_string_literal: true

module Api
  module V1
    class AccountsController < ApiController
      before_action :retrieve_data, only: :index

      def index
        return render json: { message: "No account information" }, status: :not_found if @data.nil?

        render json: AccountPresenter.json_collection(@data), status: :ok
      end

      def show; end

      private
        def retrieve_data
          @data = AccountRepository.find_customer_info(@data_token[:uuid])
        end
    end
  end
end
