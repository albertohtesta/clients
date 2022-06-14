
class Api::V1::AppMigrationsController < JwtAuthAppsController

  before_action :authenticate_request

  #POST /api/v1/apps/accounts
  def accounts
    #Account.migrate(resource_params(:accounts))
    render json: @accounts
  end

  #POST /api/v1/apps/projects
  def projects
    #Project.migrate(resource_params(:projects))
    render json: @projects
  end

private

  def resource_params(resource_param)
    params.require(param_resource)
  end

end