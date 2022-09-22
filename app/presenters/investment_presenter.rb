# frozen_string_literal: true

class InvestmentPresenter < ApplicationPresenter
  class << self
    def order_by_quarters(investments)
      return {} if investments.blank?

      current_quarter = (Time.now.month / 3).ceil
      quarter_first_month = (current_quarter - 1) * 3 + 1
      month_range = (quarter_first_month..quarter_first_month + 2).to_a

      value_sum = investments
          .select { |inv| month_range.include? inv.date.month }
          .sum(&:value)

      quarters = { current_quarter => value_sum }
      {
        project_indicators: data_hash(quarters, "quarter")
      }
    end

    def order_by_monthly(investments)
      return {} if investments.blank?

      month_range = [Time.now.month - 1]

      value_sum = investments
          .select { |inv| month_range.include? inv.date.month }
          .sum(&:value)
      months = { month_range[0] => value_sum }
      {
        project_indicators: data_hash(months, "month")
      }
    end

    private
      def data_hash(items, type)
        items.map do |id, value|
          {
            "label" => (type == "month") ? Date::MONTHNAMES[id] : "Q#{id}",
            "value" => value.round(2)
          }
        end
      end
  end
end
