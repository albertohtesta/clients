# frozen_string_literal: true

class CreateTechStacks < ActiveRecord::Migration[7.0]
  def change
    create_table :tech_stacks do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
