class AddMobileNoToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :mobile_no, :integer
  end
end
