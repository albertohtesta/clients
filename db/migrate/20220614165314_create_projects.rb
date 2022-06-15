class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.date :start_date, null: false
      t.date :end_date
      t.string :description
      t.date :delivery_dates
      t.date :demo_dates
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
