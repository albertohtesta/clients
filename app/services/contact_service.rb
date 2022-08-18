# frozen_string_literal: true

# create account user
class ContactService < ApplicationService
  def create
    @account = AccountContactCollaboratorRepository.contacts_by_account(params[:account_name])

    if !@account
      render json: { message: "Invalid account name" }, status: :unprocessable_entity
    else
      @account.verify_token(params[:name])
      token = JWT.encode({
        account_id: @account.id,
        account_account_uuid: @account.account_uuid,
        accounnt_name: @account.name,
        account_contact_email: @account.contact_email
      })

      render json: { token:, name: @account.name }, status: :Ok
    end
  end
end
