class ChangeApiTokenToApiName < ActiveRecord::Migration[7.0]
  def up
    rename_column :app_connections, :api_token, :api_name
  end

  def down
    rename_column :app_connections, :api_name, :api_token
  end
end
