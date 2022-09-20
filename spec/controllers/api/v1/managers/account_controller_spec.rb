# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::Managers::AccountsController, type: :controller do
  include_context "login_user"

  describe "#index" do
    context "when an account has metrics follow ups" do
      let(:date) { 2.weeks.ago.beginning_of_day }
      let(:collaborator) { create(:collaborator) }
      let(:account_status) { create(:account_status, status: "new", status_code: "new") }
      let(:account) { create(:account, city: "city", manager: collaborator, account_status:) }
      let(:project) { create(:project, account:) }
      let(:team) { create(:team, project:) }
      let(:account_follow_up) { create(:account_follow_up, account:, follow_date: date) }

      let!(:account_metric_team_balance) { create(:metric, related: team, date:, indicator_type: "balance", value: 95) }
      let!(:account_metric_velocity) { create(:metric, related: team, date:, indicator_type: "velocity", value: 95) }
      let!(:account_metric_client_management) { create(:metric, related: team, date:, indicator_type: "client_management", value: 95) }
      let!(:account_metric_performance) { create(:metric, related: team, date:, indicator_type: "performance", value: 95) }
      let!(:account_metric_gross_margin) { create(:metric, related: team, date:, indicator_type: "gross_margin", value: 95) }
      let!(:account_metric_morale) { create(:metric, related: team, date:, indicator_type: "morale", value: 95) }

      let!(:metric_follow_up_team_balance) { create(:metric_follow_up, follow_date: date, metric_type: "balance", account:, manager: collaborator, created_at: date, updated_at: date) }
      let!(:metric_follow_up_client_management) { create(:metric_follow_up, follow_date: date, metric_type: "client_management", account:, manager: collaborator, created_at: date, updated_at: date) }
      let!(:metric_follow_up_performance) { create(:metric_follow_up, follow_date: date, metric_type: "performance", account:, manager: collaborator, created_at: date, updated_at: date) }
      let!(:metric_follow_up_gross_margin) { create(:metric_follow_up, follow_date: date, metric_type: "gross_margin", account:, manager: collaborator, created_at: date, updated_at: date) }
      let!(:metric_follow_up_morale) { create(:metric_follow_up, follow_date: date, metric_type: "morale", account:, manager: collaborator, created_at: date, updated_at: date) }
      let!(:metric_follow_up_velocity) { create(:metric_follow_up, follow_date: date, metric_type: "velocity", account:, manager: collaborator, created_at: date, updated_at: date) }

      let!(:metric_limit_balance) { create(:metric_limit, indicator_type: "balance") }
      let!(:metric_limit_velocity) { create(:metric_limit, indicator_type: "velocity") }
      let!(:metric_limit_gross_marging) { create(:metric_limit, indicator_type: "gross_margin") }
      let!(:metric_limit_morale) {
        create(
          :metric_limit,
          indicator_type: "morale",
          low_priority_min: 90,
          low_priority_max: 100,
          medium_priority_min: 80,
          medium_priority_max: 89,
          high_priority_min: 0,
          high_priority_max: 79
        )
      }
      let!(:metric_limit_performance) {
        create(
          :metric_limit,
          indicator_type: "performance",
          low_priority_min: 90,
          low_priority_max: 100,
          medium_priority_min: 80,
          medium_priority_max: 89,
          high_priority_min: 0,
          high_priority_max: 79
        )
      }
      let!(:metric_limit_balance) {
        create(
          :metric_limit,
          indicator_type: "balance",
          low_priority_min: 90,
          low_priority_max: 100,
          medium_priority_min: 80,
          medium_priority_max: 89,
          high_priority_min: 0,
          high_priority_max: 79
        )
      }

      let!(:metric_limit_client_management) {
        create(
          :metric_limit,
          indicator_type: "client_management",
          low_priority_min: 90,
          low_priority_max: 100,
          medium_priority_min: 80,
          medium_priority_max: 89,
          high_priority_min: 0,
          high_priority_max: 79
        )
      }

      it "must return each metric value" do
        expected_keys = [
          { "id" => account.id,
            "account_uuid" => account.account_uuid,
            "name" => "MyString",
            "location" => "city",
            "last_follow_up_text" => "No follow ups found",
            "priority" => "medium",
            "role_debt" => 0,
            "alert" => true,
            "team_balance" => {
              "amount" => 95,
              "alert" => false,
              "data_follow_up" => JSON.parse(metric_follow_up_team_balance.to_json(except: [:created_at, :updated_at]))
            },
            "client_management" => {
              "amount" => 95,
              "alert" => false,
              "data_follow_up" => JSON.parse(metric_follow_up_client_management.to_json(except: [:created_at, :updated_at]))
            },
            "performance" => {
              "amount" => 95,
              "alert" => false,
              "data_follow_up" => JSON.parse(metric_follow_up_performance.to_json(except: [:created_at, :updated_at]))
            },
            "gross_margin" => {
              "amount" => 95,
              "alert" => false,
              "data_follow_up" => JSON.parse(metric_follow_up_gross_margin.to_json(except: [:created_at, :updated_at]))
            },
            "morale" => {
              "amount" => 95,
              "alert" => false,
              "data_follow_up" => JSON.parse(metric_follow_up_morale.to_json(except: [:created_at, :updated_at]))
            },
            "velocity" => {
              "amount" => 95,
              "alert" => false,
              "data_follow_up" => JSON.parse(metric_follow_up_velocity.to_json(except: [:created_at, :updated_at]))
            },
          "manager_id" => collaborator.id
          }
        ]

        request.headers["Authorization"] = @token
        get :index, params: { manager_id: account.manager_id }
        expect(JSON.parse(response.body)).to eql(expected_keys)
      end
    end
  end
end
