# frozen_string_literal: true

class RemoveColaborators < ActiveRecord::Migration[7.0]
  def change
    drop_table :colaborators_tools
    drop_table :colaborators_tech_stacks
    drop_table :colaborators_teams
    drop_table :colaborators
  end
end
