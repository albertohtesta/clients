# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::Managers::AccountsController, type: :controller do
  describe "#index" do
    context "when an account has metrics follow ups" do
      let(:collaborator) { create(:collaborator) }
      let(:account) { create(:account, city: "city", manager: collaborator, account_status:) }
      let(:contact) { create(:contact, :user, account:) }
      let(:Authorization) { @token }
      let(:metric_date) { 3.weeks.ago.beginning_of_day }
      let(:date) { 2.weeks.ago.beginning_of_day }
      let(:account_status) { create(:account_status, status: "new", status_code: "new") }
      let(:project) { create(:project, account:) }
      let(:team) { create(:team, project:) }
      let!(:account_follow_up) { create(:account_follow_up, account:, follow_date: date) }
      let!(:team_balance) { create(:team_balance, account_id: account.id, team:) }
      let!(:account_metric_team_balance) { create(:metric, related: account, date: metric_date, indicator_type: "balance", value: 95) }
      let!(:account_metric_velocity) { create(:metric, related: account, date: metric_date, indicator_type: "velocity", value: 95) }
      let!(:account_metric_performance) { create(:metric, related: account, date: metric_date, indicator_type: "performance", value: 95) }
      let!(:account_metric_morale) { create(:metric, related: account, date: metric_date, indicator_type: "morale", value: 95) }

      let!(:metric_follow_up_team_balance) {
        @metric_follow_up_team_balance = create(:metric_follow_up, follow_date: date, metric_type: "balance", account:, manager: collaborator, created_at: date, updated_at: date)
        @metric_follow_up_team_balance.id = account_metric_team_balance.id
        @metric_follow_up_team_balance
      }
      let!(:metric_follow_up_performance) {
        @metric_follow_up_performance = create(:metric_follow_up, follow_date: date, metric_type: "performance", account:, manager: collaborator, created_at: date, updated_at: date)
        @metric_follow_up_performance.id = account_metric_performance.id
        @metric_follow_up_performance
      }
      let!(:metric_follow_up_morale) {
        @metric_follow_up_morale ||= create(:metric_follow_up, follow_date: metric_date, metric_type: "morale", account:, manager: collaborator, created_at: date, updated_at: date)
        @metric_follow_up_morale.id = account_metric_morale.id
        @metric_follow_up_morale
      }
      let!(:metric_follow_up_velocity) {
        @metric_follow_up_velocity = create(:metric_follow_up, follow_date: nil, metric_type: "velocity", account:, manager: collaborator, created_at: date, updated_at: date)
        @metric_follow_up_velocity.id = account_metric_velocity.id
        @metric_follow_up_velocity
      }

      let!(:metric_limit_velocity) { create(:metric_limit, indicator_type: "velocity") }
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
          low_priority_min: 81,
          low_priority_max: 100,
          medium_priority_min: 60,
          medium_priority_max: 80,
          high_priority_min: 0,
          high_priority_max: 59
        )
      }

      it "must return each metric value" do
        login_as(contact)
        expected_keys = [
          { "id" => account.id,
            "account_uuid" => account.account_uuid,
            "name" => "MyString",
            "minilogo" => nil,
            "location" => "city",
            "last_follow_up_text" => "14 days ago",
            "priority" => "low",
            "role_debt" => 0,
            "alert" => "low",
            "collaborators_number" => 0,
            "collaborators" => [],
            "team_balance" => {
              "amount" => 95,
              "alert" => "low",
              "attended_after_metric" => false,
              "expected_points" => 0,
              "data_follow_up" => JSON.parse(metric_follow_up_team_balance.to_json(except: [:created_at, :updated_at]))
            },
            "performance" => {
              "amount" => 95,
              "alert" => "low",
              "attended_after_metric" => false,
              "expected_points" => 0,
              "data_follow_up" => JSON.parse(metric_follow_up_performance.to_json(except: [:created_at, :updated_at]))
            },
            "morale" => {
              "amount" => 95,
              "alert" => "low",
              "data_follow_up" => JSON.parse(metric_follow_up_morale.to_json(except: [:created_at, :updated_at])),
              "attended_after_metric" => false,
              "expected_points" => 0,
            },
            "velocity" => {
              "amount" => 95,
              "alert" => "low",
              "attended_after_metric" => false,
              "expected_points" => 0,
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

    context "when an account has no follow ups" do
      let(:collaborator) { create(:collaborator) }
      let(:account) { create(:account, city: "city", manager: collaborator, account_status:) }
      let(:contact) { create(:contact, :user, account:) }
      let(:Authorization) { @token }
      let(:metric_date) { 3.weeks.ago.beginning_of_day }
      let(:date) { 2.weeks.ago.beginning_of_day }
      let(:account_status) { create(:account_status, status: "new", status_code: "new") }
      let(:project) { create(:project, account:) }
      let(:team) { create(:team, project:) }

      it "must respond on empty values" do
        login_as(contact)
        expected_keys = [
          { "id" => account.id,
            "account_uuid" => account.account_uuid,
            "name" => "MyString",
            "location" => "city",
            "minilogo" => nil,
            "last_follow_up_text" => "No follow ups found",
            "priority" => "medium",
            "role_debt" => 0,
            "alert" => "medium",
            "collaborators_number" => 0,
            "collaborators" => [],
            "team_balance" => {
              "amount" => 0,
              "alert" => "low",
              "attended_after_metric" => false,
              "data_follow_up" => {
                "account_id" => account.id,
                "id" => nil,
                "manager_id" => account.manager_id,
                "metric_type" => "balance"
                },
                "expected_points" => 0
            },
            "performance" => {
              "amount" => 0,
              "alert" => "low",
              "attended_after_metric" => false,
              "data_follow_up" => {
                "account_id" => account.id,
                "id" => nil,
                "manager_id" => account.manager_id,
                "metric_type" => "performance"
                },
                "expected_points" => 0
            },
            "morale" => {
              "amount" => 0,
              "alert" => "low",
              "data_follow_up" => {
                "account_id" => account.id,
                "id" => nil,
                "manager_id" => account.manager_id,
                "metric_type" => "morale"
                },
              "attended_after_metric" => false,
              "expected_points" => 0
            },
            "velocity" => {
              "amount" => 0,
              "alert" => "low",
              "attended_after_metric" => false,
              "data_follow_up" => {
                "account_id" => account.id,
                "id" => nil,
                "manager_id" => account.manager_id,
                "metric_type" => "velocity"
                },
              "expected_points" => 0
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
