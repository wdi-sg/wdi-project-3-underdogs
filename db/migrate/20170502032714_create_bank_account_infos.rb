class CreateBankAccountInfos < ActiveRecord::Migration[5.0]

  def change
    create_table :bank_account_infos do |t|
      t.string :bank_name
      t.string :bank_currency
      t.integer :account_no
      t.string :name_on_account
      t.string :branch_code
      t.references :user

      t.timestamps
    end
  end
end
