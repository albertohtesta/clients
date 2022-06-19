# frozen_string_literal: true

class CreateJoinTableCollaboratorTeam < ActiveRecord::Migration[7.0]
  def change
    create_join_table :collaborators, :teams do |t|
      t.index %i[collaborator_id team_id]
    end
  end
end
