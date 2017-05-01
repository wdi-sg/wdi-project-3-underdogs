class RemoveColumnFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :add_dob_to_users, :string
  end
end
