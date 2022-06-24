class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.string :salesforce_id
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.references :account, null: false, foreign_key: true
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
