class CreateJoinTableCollaboratorTool < ActiveRecord::Migration[7.0]
  def change
    create_join_table :collaborators, :tools do |t|
      t.index [:collaborator_id, :tool_id]
    end
  end
end
