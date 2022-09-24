# frozen_string_literal: true

class InvestmentPresenter < ApplicationPresenter
  class << self
    def order_by_quarters(investments)
      return {} if investments.blank?
      # quarters setup for a single year
      quarters = {}
      investments.each do |invested|
        quarter = (invested.date.month / 3.0).ceil
        quarters[quarter] = quarters[quarter].to_d + invested.value
      end
      {
        project_indicators: data_hash(quarters, "quarter")
      }
    end

    def order_by_months(investments)
      return {} if investments.blank?
      months = {}
      investments.each do |invested|
        months[invested.date.month] = months[invested.date.month].to_d + invested.value
      end
      {
        project_indicators: data_hash(months, "month")
      }
    end

    private
      def data_hash(items, type)
        items.map do |id, value|
          {
            "id" => id,
            "label" => (type == "month") ? Date::MONTHNAMES[id] : "q#{id}",
            "value" => value.round(2)
          }
        end
      end
  end
end
