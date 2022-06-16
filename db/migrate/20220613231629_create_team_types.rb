# frozen_string_literal: true

class CreateTeamTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :team_types do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
