class AddNicknameToCollaborators < ActiveRecord::Migration[7.0]
  def change
    add_column :collaborators, :nickname, :string
  end
end
