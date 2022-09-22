class AddLogoToAccount < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :logo, :string
    add_column :accounts, :display_brand, :integer, default: 2
  end
end
