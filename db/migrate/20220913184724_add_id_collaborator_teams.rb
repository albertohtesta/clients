class AddIdCollaboratorTeams < ActiveRecord::Migration[7.0]
  def change
    add_column :collaborators_teams, :id, :primary_key
  end
end
