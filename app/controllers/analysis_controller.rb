class AnalysisController < ApplicationController
before_action :authenticate_user!


  def index
    @user = User.find(current_user)
    @income = Income.where(user_id: current_user.id)[0]
    @final = Income.select("final_savings_goal").where(user_id: current_user.id).sum("final_savings_goal")
    @monthly = Income.select("monthly_savings_goal").where(user_id: current_user.id).sum("monthly_savings_goal")
    @monthlyinterest = (@monthly*0.003*12).to_f + @monthly
    @originaltime = @final.to_f/@monthlyinterest.to_f
    @saved = Transaction.select("transacted_amount").where(user_id: current_user.id).sum("transacted_amount")
    @interest = @saved*0.003*12
    @totalsaved = @saved + @interest
    @finaltime = @final.to_f/@totalsaved

    puts '@final is the final savings goal of the user'
    puts @final
    puts '@saved is the total savings amount in Cache account'
    puts @saved
    puts '@interest 3% of the 1% for Cash Back x 12 months'
    puts @interest
    puts '@totalsaved is the total savings plus cash back'
    puts @totalsaved
    puts '@monthly is the Monthly Savings Goal entered by user'
    puts @monthly
    puts '@monthlyinterest is the Monthly savings goal plus cash back if the user topped up monthly'
    puts @monthlyinterest
    puts '@originaltime is the final savings goal divided by the monthly interest plus cash back if user topped up mthly'
    puts @originaltime
    puts '@finaltime is the final savings goal divided by mthly savings goal entered by user'
    puts @finaltime
  end

  def update
    @income = Income.where(user_id: current_user.id)
    @income.update(income_params)
    flash[:notice] = "You have updated your savings goals. Check out your new analysis report!"
    redirect_to analysis_index_path
  end

  private

  def income_params
    params.require(:income).permit(:monthly_income, :monthly_savings_goal, :final_savings_goal)
  end
end
