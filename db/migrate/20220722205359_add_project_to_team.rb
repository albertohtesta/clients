class AddProjectToTeam < ActiveRecord::Migration[7.0]
  def up
    add_reference :teams, :project, foreign_key: true
  end

  def down
    remove_reference :teams, :project, foreign_key: true
  end
end
