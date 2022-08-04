class CreateCollaboratorBadges < ActiveRecord::Migration[7.0]
  def change
    create_table :collaborators_badges do |t|
      t.references :collaborator, null: false, foreign_key: true
      t.references :badge, null: false, foreign_key: true

      t.timestamps
    end
  end
end
