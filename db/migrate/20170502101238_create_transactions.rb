class CreateTransactions < ActiveRecord::Migration[5.0]

  def change
    create_table :transactions do |t|
      t.integer :transacted_amount
      t.date :transacted_date
      t.integer :transaction_no
      t.references :user
      t.references :bank_account_info

      t.timestamps
    end
  end
end
