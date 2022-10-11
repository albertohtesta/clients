class AddMinilogoToAccount < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :minilogo, :string
  end
end
