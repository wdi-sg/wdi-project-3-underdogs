class HomepageController < ApplicationController

  def homepage
    @user = User.new

    @financial_header_array = ['Monthly Salary', 'Annual Salary', 'Savings Ratio', 'Annual Savings', 'Cache Dollars', 'Cash Back', 'Total Incentives']
    @mthly_sal = 3000
    @save_ratio = 20
    @annual_savings = (@mthly_sal.to_f * @save_ratio.to_f/100) * 12
    @twelve_percent_of_savings = @annual_savings * 0.12

  end

  def publicanalysis
    @user = User.new
  end

end
