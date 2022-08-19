class AddInviteInfoToContacts < ActiveRecord::Migration[7.0]
  def change
    add_column :contacts, :invite_status, :string
    add_column :contacts, :invite_date, :date
    add_column :contacts, :contact_uuid, :string
  end
end
