class CreateAccountCollaborators < ActiveRecord::Migration[7.0]
  def change
    create_table :account_collaborators, id: false do |t|
      t.belongs_to :account
      t.belongs_to :collaborator
    end
  end
end
