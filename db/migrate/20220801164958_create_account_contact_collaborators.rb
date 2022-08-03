class CreateAccountContactCollaborators < ActiveRecord::Migration[7.0]
  def change
    create_table :account_contact_collaborators, id: false do |t|
      t.belongs_to :account
      t.belongs_to :collaborator
    end
  end
end
