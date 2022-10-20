# frozen_string_literal: true

METRICS_TYPES = {
  balance: "balance", # team
  velocity: "velocity", # team
  morale: "morale", # both
  performance: "performance", # both
  team_balance: "team balance", # account
  gross_margin: "gross margin", # account
  client_engagement: "client engagement", # account
  client_management: "client management" # account
}

SENIORITY_TYPES = {
  junior: "Junior",
  middle: "Middle",
  senior: "Senior"
}

ALERT = {
  high: "high",
  medium: "medium",
  low: "low",
  no_team: "no-team",
  no_connector: "no-connector",
  no_dataset: "no-dataset"
}
