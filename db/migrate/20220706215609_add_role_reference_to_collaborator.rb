class AddRoleReferenceToCollaborator < ActiveRecord::Migration[7.0]
  def up
    add_reference(:collaborators, :role, foreign_key: true, index: true)

    role = Role.create!(name: 'Developer')
    Collaborator.update_all(role_id: role.id)

    change_column_null(:collaborators, :role_id, false)
  end

  def down
    remove_reference :collaborators, :role, foreign_key: true, index: true
  end
end
