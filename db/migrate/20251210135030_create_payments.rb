class CreatePayments < ActiveRecord::Migration[8.1]
  def change
    create_table :payments do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.decimal :amount
      t.string :currency
      t.string :reference
      t.datetime :paid_at

      t.timestamps
    end
  end
end
