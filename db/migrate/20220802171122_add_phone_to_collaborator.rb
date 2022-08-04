class AddPhoneToCollaborator < ActiveRecord::Migration[7.0]
  def change
    add_column :collaborators, :phone, :string
  end
end
