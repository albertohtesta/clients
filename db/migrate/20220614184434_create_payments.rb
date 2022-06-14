class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.datetime :payment_date
      t.date :cut_off_date, null: false
      t.date :payday_limit, null: false
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
