class CreateMetrics < ActiveRecord::Migration[7.0]
  def change
    create_table :metrics do |t|
      t.references :project, null: false, foreign_key: true
      t.text :metrics, null: false
      t.string :indicator_type, null: false
      t.string :group_by, null: false
      t.date :from_date, null: false
      t.date :to_date, null: false
      t.timestamps
    end
  end
end
