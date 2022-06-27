# frozen_string_literal: true

class CreateAppConnections < ActiveRecord::Migration[7.0]
  def change
    create_table :app_connections do |t|
      t.string :name, null: false
      t.string :api_token, null: false
      t.string :secret_token_digest, null: false

      t.timestamps
    end
  end
end
