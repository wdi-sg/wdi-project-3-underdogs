class CreateRedeemeds < ActiveRecord::Migration[5.0]
  def change
    create_table :redeemeds do |t|
      t.references :reward
      t.references :user

      t.timestamps
    end
  end
end
