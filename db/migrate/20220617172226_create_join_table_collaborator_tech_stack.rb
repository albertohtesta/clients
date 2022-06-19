# frozen_string_literal: true

class CreateJoinTableCollaboratorTechStack < ActiveRecord::Migration[7.0]
  def change
    create_join_table :collaborators, :tech_stacks do |t|
      t.index %i[collaborator_id tech_stack_id], name: "index_collaborators_tech_stacks_on_colaborator_and_tech_stack"
    end
  end
end
