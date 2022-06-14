class CreateColaborators < ActiveRecord::Migration[7.0]
  def change
    create_table :colaborators do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :uuid, null: false

      t.timestamps
    end
  end
end
