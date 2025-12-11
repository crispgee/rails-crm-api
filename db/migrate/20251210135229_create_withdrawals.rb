class CreateWithdrawals < ActiveRecord::Migration[8.1]
  def change
    create_table :withdrawals do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.decimal :amount
      t.string :currency
      t.string :status
      t.datetime :requested_at
      t.datetime :processed_at

      t.timestamps
    end
  end
end
