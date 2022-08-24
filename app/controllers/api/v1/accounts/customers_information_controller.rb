# frozen_string_literal: true

module Api
  module V1
    module Accounts
      before_action :retrieve_data, only: :index

      def index
        return render json: { message: "No account" }, status: :not_found if @data.empty?

        render json: AccountPresenter.json_collection(@data), status: :ok
      end

      private
        def retrieve_data
          @data = AccountRepository.find_customer_info(@data_token[:uuid])
        end
    end
  end
end
