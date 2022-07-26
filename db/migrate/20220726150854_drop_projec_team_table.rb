class DropProjecTeamTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :projects_teams
  end
end
