class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams do |t|
      t.datetime :added_date, null: false
      t.references :team_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
