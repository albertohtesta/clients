# frozen_string_literal: true

class InvestmentPresenter < ApplicationPresenter
  def month
    date.month
  end

  def quarter
    (month / 3.0).ceil
  end

  class << self
    def order_by_quarter(investments)
      quarters = prepare_items(investments, 4, "quarter")

      prepare_hash(quarters, "quarter")
      end

    def order_by_monthly(investments)
      months = prepare_items(investments, 12, "month")

      prepare_hash(months, "month")
    end

      private
        def prepare_hash(items, type)
          items.map do |id, value|
            {
              "label" => (type == "month") ? Date::MONTHNAMES[id] : "Q#{id}",
              "value" => value.round(2)
            }
          end
          end

        def prepare_items(investments, slots, type)
          items = (1..slots).map { |n| { n => 0 } }.reduce(:merge)

          investments.each do |investment|
            presenter = InvestmentPresenter.new(investment)
            items[presenter.send(type)] += presenter.value
          end
          items
        end
  end
end
