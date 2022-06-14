class CreateAppConnections < ActiveRecord::Migration[7.0]
  def change
    create_table :create_app_connections do |t|
      t.string :api_token
      t.string :secret_token

      t.timestamps
    end
  end
end