class CreateTeamRequirements < ActiveRecord::Migration[7.0]
  def change
    create_table :team_requirements do |t|
      t.references :account, foreign_key: true, null: false
      t.references :team, foreign_key: true, null: false
      t.references :collaborator, foreign_key: true, null: true
      t.references :role, foreign_key: true, null: false
      t.string :seniority, null: false

      t.timestamps
    end
  end
end
