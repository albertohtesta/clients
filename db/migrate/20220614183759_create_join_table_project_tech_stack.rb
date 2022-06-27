# frozen_string_literal: true

class CreateJoinTableProjectTechStack < ActiveRecord::Migration[7.0]
  def change
    create_join_table :projects, :tech_stacks do |t|
      t.index %i[project_id tech_stack_id]
    end
  end
end
