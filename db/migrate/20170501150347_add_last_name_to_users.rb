class AddLastNameToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :last_name, :string
    add_column :users, :add_dob_to_users, :string
    add_column :users, :dob, :date
  end
end
