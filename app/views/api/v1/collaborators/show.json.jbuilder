# frozen_string_literal: true

json.count @collaborator.accounts.size
json.collaborator_id @collaborator.id
json.accounts do
  json.array! @collaborator.accounts, partial: "api/v1/accounts/account", as: :account
end
