class AddPolimorficIdToMetrics < ActiveRecord::Migration[7.0]
  def change
    remove_reference :metrics, :team, foreign_key: true

    add_reference :metrics, :related, polymorphic: true, index: true
  end
end
