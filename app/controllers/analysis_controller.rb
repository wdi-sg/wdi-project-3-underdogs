class AnalysisController < ApplicationController
before_action :authenticate_user!


  def index
    @user = User.find(current_user)
    @income = Income.where(user_id: current_user.id)[0]

    @final = Income.select("final_savings_goal").where(user_id: current_user.id).sum("final_savings_goal")
    @monthly = Income.select("monthly_savings_goal").where(user_id: current_user.id).sum("monthly_savings_goal")
    @monthlyinterest = (@monthly*0.003*6).to_f + @monthly
    @originaltime = @final.to_f/@monthlyinterest.to_f
    @saved = Transaction.select("transacted_amount").where(user_id: current_user.id).sum("transacted_amount")
    @interest = @saved*0.003*6
    @totalsaved = @saved + @interest
    @finaltime = @final.to_f/@totalsaved
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
