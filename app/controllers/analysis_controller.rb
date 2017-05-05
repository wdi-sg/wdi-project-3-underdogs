class AnalysisController < ApplicationController
before_action :authenticate_user!
  def index
    @user = User.find(current_user)
  end

  def update

    @income = Income.where(user_id: current_user.id)
    if @income.blank?
      @income = Income.new (income_params)
      @income.user_id = current_user.id
      @income.save
    else
      @income.update(income_params)
    end
      redirect_to profiles_path
  end

  private

  def income_params
    params.require(:income).permit(:monthly_income, :monthly_savings_goal, :final_savings_goal)
  end
end
