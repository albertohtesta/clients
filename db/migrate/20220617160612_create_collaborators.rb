# frozen_string_literal: true

class CreateCollaborators < ActiveRecord::Migration[7.0]
  def change
    create_table :collaborators do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :uuid, null: false

      t.timestamps
    end
  end
end
