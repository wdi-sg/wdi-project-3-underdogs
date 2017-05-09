class AnalysisController < ApplicationController
before_action :authenticate_user!


  def index
    @user = User.find(current_user)
    @income = Income.where(user_id: current_user.id)[0]
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
