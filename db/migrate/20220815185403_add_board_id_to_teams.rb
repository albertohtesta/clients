class AddBoardIdToTeams < ActiveRecord::Migration[7.0]
  def change
    add_column :teams, :board_id, :string, index: true, unique: true
  end
end
