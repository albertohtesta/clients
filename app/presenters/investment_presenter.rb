# frozen_string_literal: true

class InvestmentPresenter < ApplicationPresenter
  def month
    date.month
  end

  def quarter
    (month / 3.0).ceil
  end

  class << self
    def order_by_quarters(investments)
      quarters = prepare_last_period(investments, "quarter")

      prepare_hash(quarters, "quarter")
      end

    def order_by_months(investments)
      months = prepare_last_period(investments, "month")

      prepare_hash(months, "month")
    end

      private
        def prepare_hash(items, type)
          items.map do |id, value|
            {
              "id" => id,
              "label" => (type == "month") ? Date::MONTHNAMES[id] : "q#{id}",
              "value" => value.round(2)
            }
          end
        end

        def prepare_last_period(investments, type)
          return {} if investments.nil? || investments.empty?
          current_month = Time.now.month
          current_quarter = (current_month / 3).ceil
          quarter_first_month = (current_quarter - 1) * 3 + 1
          # go for previous month, or current quarter
          month_range = {
            "month" => [current_month - 1],
            "quarter" => (quarter_first_month..quarter_first_month + 2).to_a
          }[type]
          value_sum = investments
              .select { |inv| month_range.include? inv.date.month }
              .sum(&:value)
          period_number = {
            "month" => current_month - 1,
            "quarter" => current_quarter
          }[type]
          { period_number => value_sum }
        end
  end
end
