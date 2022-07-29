class UpdateCollaboratorsTable < ActiveRecord::Migration[7.0]
  def change
    add_column :collaborators, :position, :string
    add_column :collaborators, :profile, :string
    add_column :collaborators, :seniority, :string
    add_column :collaborators, :english_level, :string
    add_column :collaborators, :about, :text
    add_column :collaborators, :work_modality, :string
  end
end
