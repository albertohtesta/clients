# frozen_string_literal: true

class InvestmentPresenter < ApplicationPresenter
  class << self
    def order_by_quarter(investments)
      return {} if investments.blank?
      # quarters setup for a single year
      quarters = {}
      current_quarter = (Time.now.to_date.month / 3.0).ceil
      (1..current_quarter).each do |q|
        quarters[q] = 0.to_d
      end
      investments.each do |invested|
        quarter = (invested.date.month / 3.0).ceil
        quarters[quarter] = quarters[quarter].to_d + invested.value.to_d
      end
      {
        project_indicators: data_hash(quarters, "quarter")
      }
    end

    def order_by_monthly(investments)
      return {} if investments.blank?
      months = {}

      InvestmentService.investments_by_team(investments)

      investments.each do |invested|
        months[invested.date.month] = months[invested.date.month].to_d + invested.value.to_d
      end
      {
        project_indicators: data_hash(months, "month")
      }
    end

    private
      def data_hash(items, type)
        items.map do |id, value|
          {
            "label" => (type == "month") ? Date::MONTHNAMES[id] : "Q#{id}",
            "value" => value.to_f
          }
        end
      end
  end
end
