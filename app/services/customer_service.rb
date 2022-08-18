# frozen_string_literal: true

# create account user
class CustomerService < ApplicationService
  def create
    @account = AccountContactCollaboratorRepository.contacts_by_account(params[:account_name])

    if !@account
      render json: { message: "Invalid account name" }, status: :unprocessable_entity
    elsif @account.authenticate(params[:name])
      secret_key = ENV["SECRET_KEY"]
      token = JWT.encode({
        account_id: @account.id,
        account_account_uuid: @account.account_uuid,
        accounnt_name: @account.name,
        account_contact_email: @account.contact_email
      }, secret_key)

      render json: { token:, name: @account.name }, status: :Ok
    else
      render json: { error: "Invalide account name" }, status: :unprocessable_entity
    end
  end
end
