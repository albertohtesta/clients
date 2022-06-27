class RenameFollowHistoryTable < ActiveRecord::Migration[7.0]
  def change
    rename_table('follow_histories', 'account_follow_ups')
  end
end
