# frozen_string_literal: true

module Api
  module V1
    module TeamMorale
      class MoraleAttributesController < ApplicationController
        def index
          @morale_attributes = MoraleAttribute.all
          render json: @morale_attributes, include: [:survey_questions]
        end
      end
    end
  end
end
