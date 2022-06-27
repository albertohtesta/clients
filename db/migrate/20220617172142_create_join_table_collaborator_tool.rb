# frozen_string_literal: true

class CreateJoinTableCollaboratorTool < ActiveRecord::Migration[7.0]
  def change
    create_join_table :collaborators, :tools do |t|
      t.index %i[collaborator_id tool_id]
    end
  end
end
