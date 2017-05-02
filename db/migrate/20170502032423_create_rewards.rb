class CreateRewards < ActiveRecord::Migration[5.0]
  def change
    create_table :rewards do |t|
      t.string :merchant
      t.string :merchant_code
      t.string :item
      t.integer :value
      t.string :expiry_date
      t.string :category

      t.timestamps
    end
  end
end
