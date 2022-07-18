class AddLastNameToCollaborators < ActiveRecord::Migration[7.0]
  def change
    rename_column(:collaborators, :name, :first_name)
    add_column :collaborators, :last_name, :string
  end
end
