# frozen_string_literal: true

class CreateJoinTableColaboratorTool < ActiveRecord::Migration[7.0]
  def change
    create_join_table :colaborators, :tools do |t|
      t.index %i[colaborator_id tool_id]
    end
  end
end
