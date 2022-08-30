# frozen_string_literal: true

METRICS_TYPES = {
  balance: "balance", # team
  velocity: "velocity", # team
  morale: "morale", # both
  performance: "performance", # both
  team_balance: "team balance", # account
  gross_marging: "gross marging", # account
  client_engagement: "client engagement" # account
}

SENIORITY_TYPES = {
  junior: "junior",
  middle: "middle",
  sennior: "sennior"
}

# TODO: Replace for BI API url
METRICS_API_BI_URL = "https://qa-bi-api.nordhen.com/TeamPerformanceMetrics"
