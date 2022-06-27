# frozen_string_literal: true

class CreateJoinTableProjectTool < ActiveRecord::Migration[7.0]
  def change
    create_join_table :projects, :tools do |t|
      t.index %i[project_id tool_id]
    end
  end
end
