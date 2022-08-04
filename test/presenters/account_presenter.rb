# frozen_string_literal: true

require "test_helper"

class AccountPresenterTest < ActiveSupport::TestCase
  test "must return correct manager json" do
    @manager = create(:collaborator, :manager)
    @account = create(:account, { manager: @manager })

    @account_presenter = AccountPresenter.new(@account)

    @account_presenter.json(@account)

    expected_json =
        { "id" => @account.id,
          "name" => "MyString",
          "contact_name" => "MyString",
          "contact_email" => "MyString",
          "account_web_page" => "MyString",
          "review_outdated?" => false,
          "location" => nil,
          "tech_stacks" => [],
          "role_debt" => 0,
          "tools" => [],
          "payment_status" => "On Time",
          "status" => "MyString",
          "details" => {
            "balance" => 0,
            "total_projects" => 0,
            "total_teams" => 0
          },
          "finance" => {
            "blended_rate" => "0.0",
            "gross_profit" => "0.0",
            "payroll" => "0.0",
            "total_expenses" => "0.0",
            "total_revenue" => "0.0"
          },
          "health" => {
            "client_satisfaction" => 0,
            "moral" => 0
          },
          "productivity_kpis" => {
            "bugs_detected" => 0,
            "permanence" => 0,
            "productivity" => 0,
            "speed" => 0
          }
        }

    assert_equal expected_json.to_json, @account_presenter.json.to_json
  end
end
