class RewardsController < ApplicationController
before_action :authenticate_user!

  def rewards
@user = User.find(current_user)
    @total=  Transaction.select("transacted_amount").where(user_id: current_user).sum("transacted_amount")

    @credit = (@total*0.0075*6).round(0)
      #to list all rewards
      #@rewards = Rewards.all
@rewarding = @user.rewards.select("value").sum("value")
@showreward = @user.rewards.select("item", "value", "expiry", "merchant")
      my_array = [
        'A Good Start With Saving!',
        'Great Job On Saving!',
        'Let\'s Keep Saving!',
        'Excellent Work To Keep Saving!',
        'Amazing Saving Skills!',
        'Keep Up The Good Work!'
      ]
      @random_message = my_array.sample

    puts "total #{@total}"

    @cashback = (@total*0.0025*6).round(0)

    # if @total == 0
    #   redirect_to rewards_rewardslist_path
    # else
      # @user = User.find(current_user)

      @credit = (@total*0.0075*6).round(0)

      @rewarding = @user.rewards.select("value").sum("value")
      my_array = [
          'A Good Start With Saving!',
          'Great Job On Saving!',
          'Let\'s Keep Saving!',
          'Excellent Work To Keep Saving!',
          'Amazing Saving Skills!',
          'Keep Up The Good Work!'
        ]
        @random_message = my_array.sample

        @milestone_savings = {
          500 => 'You are halfway to reaching $1,000 savings!',
          1000 => 'Congratulations on reaching your 4-digit milestone!',
          2000 => 'Wow! You are in the 2\'s 4-digit zone!',
          3000 => 'Congratulations on reaching $3,000 savings!',
          4000 => 'Amazing Job on reaching $4,000 savings!',
          5000 => 'Excellent Job on being halfway to $10,000 savings!',
          6000 => 'You have $6,000 savings in your account!!! Better believe it!',
          7000 => '$7 - freakin\' thousand dollars! Outstanding!',
          8000 => 'Oh-Em-Gee! This has got to be some milestone! $8,000!!!',
          9000 => 'You are just THIS close to hitting a 5-digit savings amount! You can do it!',
          10000 => 'WOW Congratulations on hitting $10,000 Savings! Your friends want to be you right now!'
        }

        @rewards_list = Reward.all.order(:value)

        @income = Income.where(user_id: current_user.id)
        # @monthly_income = @income[0].monthly_income
        # @monthly_savings_goal = @income[0].monthly_savings_goal
        @final_savings_goal = @income[0].final_savings_goal

        if @total > 0 && @total <= 1000
          @x = 1000
        elsif @total > 1000 && @total <= 3000
          @x = 3000
        elsif @total > 3000 && @total <= 9000
          @x = 9000
        elsif @total > 9000 && @total <= 15000
          @x = 15000
        elsif @total > 15000 && @total <= 23000
          @x = 15000
        elsif @total > 23000 && @total < @final_savings_goal
          @x = @final_savings_goal
        elsif @total == @final_savings_goal || @total >= @final_savings_goal
          flash[:notice] = "Congratulations on reaching your Savings Goal! You can update your final savings goal in your profile to create new targets!"
        else
          @x = 1
        end
          @percentage_from_final_goal = (@total.round(2) / @x) * 100
      # end
  end

  def rewards_id
    #to find the specific reward
    @rewards = Reward.find(params[:id])
    @total=  Transaction.select("transacted_amount").where(user_id: current_user).sum("transacted_amount")

    @credit = (@total*0.0075*6).round(0)

    @user = User.find(current_user)
    @rewarding = @user.rewards.select("value").sum("value")
  end

  def claimed
    @rewards = Reward.find(params[:id])
    @total =  Transaction.select("transacted_amount").where(user_id: current_user).sum("transacted_amount")
    @credit = (@total*0.0075*6).round(0)
    @user = User.find(current_user)
    @rewarding = @user.rewards.select("value").sum("value")
    if @rewards.value > @credit-@rewarding
      flash[:notice] = "You do not have enough Cache Dollars to redeem this reward."
      redirect_to rewards_path
    else
      current_user.rewards << Reward.find(params[:id])
      current_user.save
        flash[:notice] = "You have claimed #{@rewards.item} from #{@rewards.merchant}. Please flash this page to our retailers upon redemption and cite this promotion code: #{@rewards.merchant_code}."
        redirect_to rewards_path

    end
  end


  def rewardslist
    @rewards_list = Reward.all.order(:value)
  end


end
