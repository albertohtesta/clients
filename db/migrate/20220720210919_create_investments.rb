class CreateInvestments < ActiveRecord::Migration[7.0]
  def change
    create_table :investments do |t|
      t.references :team, index: true, foreign_key: true
      t.float :value, default: 0.0
      t.date :date, null:false, index: true

      t.timestamps
    end
  end
end
