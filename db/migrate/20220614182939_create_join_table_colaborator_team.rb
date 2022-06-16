# frozen_string_literal: true

class CreateJoinTableColaboratorTeam < ActiveRecord::Migration[7.0]
  def change
    create_join_table :colaborators, :teams do |t|
      # t.index [:colaborator_id, :team_id]
    end
  end
end
