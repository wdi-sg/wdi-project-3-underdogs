class CreateIncomes < ActiveRecord::Migration[5.0]

  def change
    create_table :incomes do |t|
      t.integer :monthly_income
      t.integer :monthly_savings_goal
      t.integer :final_savings_goal
      t.references :user

      t.timestamps
    end
  end
end
