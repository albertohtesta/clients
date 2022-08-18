# frozen_string_literal: true

# Authenticate account user
class InfoService < CustomerService
  def self.authenticate
    authorization_header = request.headers[:Authorization]

    if authorization_header
      token = authorization_header.split[1]
      secret_key = ENV["SECRET_KEY"]
      decoded_token = JWT.decode(token, secret_key)

      @account = AccountContactCollaboratorRepository.contacts_by_account(decoded_token[0]["account_id"])
    else
      render status: :unauthorized
    end
  end
end
