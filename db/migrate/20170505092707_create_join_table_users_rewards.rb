class CreateJoinTableUsersRewards < ActiveRecord::Migration[5.0]
  def change
    create_join_table :users, :rewards do |t|
      # t.index [:user_id, :reward_id]
      # t.index [:reward_id, :user_id]
    end
  end
end
