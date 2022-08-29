# frozen_string_literal: true

module Api
  module V1
    module Teams
      class BalancesController < ApplicationController
        def create
          return render json: { message: "Create balance unsuccessfull" }, status: :not_found if @balance.empty?
        end
      end
    end
  end
end
