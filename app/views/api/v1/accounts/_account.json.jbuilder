# frozen_string_literal: true

json.extract! account, :id, :name, :contact_name, :contact_email, :account_web_page
json.location account.location
json.tech_stacks account.tech_stacks
json.tools account.tools
json.payment_status account.payment_status
json.status account.status
json.details account.details
json.finance account.finance
json.health account.health
json.productivity_kpis account.productivity_kpis
