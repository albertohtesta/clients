class CreateMoraleAttributes < ActiveRecord::Migration[7.0]
  def change
    create_table :morale_attributes do |t|
      t.string :name, null: false
      t.timestamps
    end
    add_index :morale_attributes, :name, unique: true
  end
end
