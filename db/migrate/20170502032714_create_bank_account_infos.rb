class CreateBankAccountInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :bank_account_infos do |t|
      t.string :email
      t.string :bank_name
      t.string :bank_currency
      t.integer :account_no
      t.string :name_on_account
      t.string :branch_code

      t.timestamps
    end
  end
end
