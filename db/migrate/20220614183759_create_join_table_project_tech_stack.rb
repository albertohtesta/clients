class CreateJoinTableProjectTechStack < ActiveRecord::Migration[7.0]
  def change
    create_join_table :projects, :tech_stacks do |t|
      t.index [:project_id, :tech_stack_id]
    end
  end
end
