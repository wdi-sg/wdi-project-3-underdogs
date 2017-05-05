class RewardsController < ApplicationController

  def rewards

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

      @total_savings = rand(1..10000)


      @rewards_list=Reward.all.order(:value)

  end

  def rewards_id
    #to find the specific reward
    @rewards = Reward.find(params[:id])
  end

  def claimed
    @rewards = Reward.find(params[:id])
    current_user.rewards << Reward.find(params[:id])
    if current_user.save
      flash[:notice] = "Promo Code for #{@rewards.merchant} is #{@rewards.item}"
    end
    redirect_to rewards_path
  end

end
