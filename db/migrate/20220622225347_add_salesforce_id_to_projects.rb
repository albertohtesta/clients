class AddSalesforceIdToProjects < ActiveRecord::Migration[7.0]
  def up
    add_column :projects, :salesforce_id, :string, after: :id
  end

  def down
    remove_column :projects, :salesforce_id, :string
  end
end
