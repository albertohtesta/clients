class AddCategoryToCollaborators < ActiveRecord::Migration[7.0]
  def change
    add_column :collaborators, :category, :string
  end
end
