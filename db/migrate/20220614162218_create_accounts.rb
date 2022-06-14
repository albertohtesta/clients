class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :account_uuid, null: false
      t.string :name, null: false
      t.string :contact_name
      t.string :contact_email
      t.string :contact_phone
      t.string :account_web_page
      t.string :service_duration

      t.timestamps
    end
  end
end
