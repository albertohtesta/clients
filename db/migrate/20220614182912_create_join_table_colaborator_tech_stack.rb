# frozen_string_literal: true

class CreateJoinTableColaboratorTechStack < ActiveRecord::Migration[7.0]
  def change
    create_join_table :colaborators, :tech_stacks do |t|
      t.index %i[colaborator_id tech_stack_id], name: "index_colaborators_tech_stacks_on_colaborator_id_and_tech_stack"
    end
  end
end
