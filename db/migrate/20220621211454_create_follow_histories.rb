class CreateFollowHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :follow_histories do |t|
      t.date :follow_date
      t.string :description
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
