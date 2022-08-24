class AddInviteInfoToContacts < ActiveRecord::Migration[7.0]
  def change
    add_column :contacts, :invite_status, :string
    add_column :contacts, :invite_date, :date
    add_column :contacts, :uuid, :string
    # validations as user
    change_column :contacts, :first_name, :string, null: false
    change_column :contacts, :last_name, :string, null: false
    change_column :contacts, :email, :string, null: false
  end
end
