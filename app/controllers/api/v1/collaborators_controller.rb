
class Api::V1::CollaboratorsController < ApplicationController
  before_action :set_collaborator

  def accounts
    @accounts = {
      count: 5,
      accounts: [
        {
          id: 1,
          name: "Atlas Forum",
          location: "San Francisco",
          status: "In Development",
          payment_status: "Debt",
          tech_stack: [
            "AWS",
            "JavaScript",
            "C#"
          ],
          tools:[
            "JIRA",
            "Git"
          ],
          productivity_kpis:{
            speed: 4,
            bugs_detected: "95%",
            permanence: 8,
            productivity: 8
          },
          details:{
            total_teams: 4,
            balance: "95%",
            total_projects: 8,
          },
          health: {
            client_satisfaction: "97%",
            moral: "95%"
          },
          finance: {
            total_revenue: 2_000_000.00,
            tools_expenses: 12_000.00,
            payroll: 1_120_000.00,
            gross_profit: 868_000.00,
            blended_rate: 280_000.00
          }
        },
        {
          id: 2,
          name: "Bright Horizon",
          location: "San Diego",
          status: "In Development",
          payment_status: "On time",
          tech_stack: [
            "AWS",
            "JavaScript",
            "C#"
          ],
          tools:[
            "JIRA",
            "Git"
          ],
          productivity_kpis:{
            speed: 4,
            bugs_detected: "95%",
            permanence: 8,
            productivity: 8
          },
          details:{
            total_teams: 4,
            balance: "95%",
            total_projects: 8,
          },
          health: {
            client_satisfaction: "97%",
            moral: "95%"
          },
          finance: {
            total_revenue: 2_000_000.00,
            tools_expenses: 12_000.00,
            payroll: 1_120_000.00,
            gross_profit: 868_000.00,
            blended_rate: 280_000.00
          }
        },
        {
          id: 3,
          name: "Concorda",
          location: "Washington",
          status: "In Development",
          payment_status: "On Time",
          tech_stack: [
            "AWS",
            "JavaScript",
            "C#"
          ],
          tools:[
            "JIRA",
            "Git"
          ],
          productivity_kpis:{
            speed: 4,
            bugs_detected: "95%",
            permanence: 8,
            productivity: 8
          },
          details:{
            total_teams: 4,
            balance: "95%",
            total_projects: 8,
          },
          health: {
            client_satisfaction: "97%",
            moral: "95%"
          },
          finance: {
            total_revenue: 2_000_000.00,
            tools_expenses: 12_000.00,
            payroll: 1_120_000.00,
            gross_profit: 868_000.00,
            blended_rate: 280_000.00
          }
        },
        {
          id: 4,
          name: "CTNU Services",
          location: "San Diego",
          status: "In Development",
          payment_status: "On Time",
          tech_stack: [
            "AWS",
            "JavaScript",
            "C#"
          ],
          tools:[
            "JIRA",
            "Git"
          ],
          productivity_kpis:{
            speed: 4,
            bugs_detected: "95%",
            permanence: 8,
            productivity: 8
          },
          details:{
            total_teams: 4,
            balance: "95%",
            total_projects: 8,
          },
          health: {
            client_satisfaction: "97%",
            moral: "95%"
          },
          finance: {
            total_revenue: 2_000_000.00,
            tools_expenses: 12_000.00,
            payroll: 1_120_000.00,
            gross_profit: 868_000.00,
            blended_rate: 280_000.00
          }
        },
        {
          id: 5,
          name: "Emvit",
          location: "Texas",
          status: "In Development",
          payment_status: "On Time",
          tech_stack: [
            "AWS",
            "JavaScript",
            "C#"
          ],
          tools:[
            "JIRA",
            "Git"
          ],
          productivity_kpis:{
            speed: 4,
            bugs_detected: "95%",
            permanence: 8,
            productivity: 8
          },
          details:{
            total_teams: 4,
            balance: "95%",
            total_projects: 8,
          },
          health: {
            client_satisfaction: "97%",
            moral: "95%"
          },
          finance: {
            total_revenue: 2_000_000.00,
            tools_expenses: 12_000.00,
            payroll: 1_120_000.00,
            gross_profit: 868_000.00,
            blended_rate: 280_000.00
          }
        }
      ]
    }

    render json: @accounts, status: :ok
  end

private

  def set_collaborator
    @collaborator_id = params[:id]
  end

end
