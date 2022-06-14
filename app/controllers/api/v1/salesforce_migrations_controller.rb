
class SalesforceMigrationsController < JwtAuthenticatedController

  def accounts
    @accounts = account_params
    Account.migrate
  end

  def projects

  end

private

  def account_params
    params.require(:accounts)
  end
end