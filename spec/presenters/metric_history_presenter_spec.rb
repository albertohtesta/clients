# frozen_string_literal: true

require "rails_helper"

RSpec.describe MetricHistoryPresenter do
  describe "presenter validation" do
    let(:metric_historial) { create(:metric_history) }
    let(:presenter) { described_class.new(metric_historial) }

    it "must return formated json" do
      expected_keys = ["id", "metric_follow_ups_id", "alert_status", "date", "mitigation_strategy"]

      expect(presenter.json.keys).to eq(expected_keys)
    end
  end
end
