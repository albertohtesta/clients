# frozen_string_literal: true

require "rails_helper"

RSpec.describe AccountInfoPresenter do
  let(:account) { create(:account) }
  let(:presenter) { described_class.new(account) }

  describe "#index" do
    it "renders the accoun as json" do
      expected_keys = %w[id account_uuid name account_web_page logo projects_ids teams_ids]

      expect(presenter.json.keys).to eql(expected_keys)
    end
  end
end
