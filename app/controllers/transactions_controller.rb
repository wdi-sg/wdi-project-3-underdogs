class TransactionsController < ApplicationController


  def index
    @user = User.find(current_user)
    @sumofmoney = Transaction.select("transacted_amount", "transacted_date").where(user_id: current_user.id)
    @total =  Transaction.select("transacted_amount").where(user_id: current_user).sum("transacted_amount")
    @credit = (@total*0.0075*12).round(0)
    puts '@CREDIT TIMES 12'
    puts @credit
    # @date = Transaction.select("created_at").where("created_at >?", 2/4/2017 )
    @rewarding = @user.rewards.select("value").sum("value")
    @cashback = (@total*0.0025*12).round(0)

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
    else
      @x = 1
    end

    @percentage_from_final_goal = (@total.round(2) / @x) * 100
  end


  def new
    @transaction = Transaction.new

    @user = User.find(current_user)
    @total=  Transaction.select("transacted_amount").where(user_id: current_user).sum("transacted_amount")
    @credit = (@total*0.0075*12).round(0)
    @cashback = (@total*0.0025*12).round(0)
    @rewarding = @user.rewards.select("value").sum("value")

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
    else
      @x = 1
    end

    @percentage_from_final_goal = (@total.round(2) / @x) * 100
  end

  def createstripe
    @amount = params[:amount]

     @amount = @amount.gsub('$', '').gsub(',', '')

     begin
       @amount = Float(@amount).round(2)
     rescue
       flash[:error] = 'Charge not completed. Please enter a valid amount in SGD ($).'
       redirect_to new_charge_path
       return
     end

     @amount = (@amount * 100).to_i # Must be an integer!

     if @amount < 500
       flash[:error] = 'Charge not completed. Donation amount must be at least $5.'
       redirect_to new_charge_path
       return
     end

     Stripe::Charge.create(
       :amount => @amount,
       :currency => 'SGD',
       :source => params[:stripeToken],
       :description => 'Custom donation'
     )

      #  how to check if the charging is completed

      @transaction = Transaction.new
      @transaction.transacted_amount = @amount/100
      puts @transaction.transacted_amount
      @transaction.transacted_date = DateTime.now.to_date
      @bank = BankAccountInfo.find(current_user.bank_account_info)
      @transaction.bank_account_info_id = @bank.id
      @transaction.user_id = current_user.id
      if @transaction.save
        redirect_to transactions_path
      else
        flash
      end

     rescue Stripe::CardError => e
       flash[:error] = e.message
       redirect_to new_charge_path
  end


  def create
    @transaction = Transaction.new(transaction_params)
    @bank = BankAccountInfo.find(current_user.bank_account_info)
    @transaction.bank_account_info_id = @bank.id
    @user = User.find(current_user)
    if @transaction.transacted_date.blank?
      @transaction.transacted_date = DateTime.now.to_date
    end
    @transaction.user_id = @user.id
    if @transaction.transacted_amount.blank?
      flash[:notice] = 'Please enter a valid amount'
      redirect_to transactions_new_path
    else
    @transaction.save
    flash[:notice] = 'You have successfully topped up your Cache savings account!'
    redirect_to transactions_path
  end
end

  def withdrawnew
    @user = User.find(current_user)
    @withdraw = Transaction.new()
    @total=  Transaction.select("transacted_amount").where(user_id: current_user).sum("transacted_amount")
    @credit = (@total*0.0075*12).round(0)
    @cashback = (@total*0.0025*12).round(0)
    @rewarding = @user.rewards.select("value").sum("value")
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
    else
      @x = 1
    end

    @percentage_from_final_goal = (@total.round(2) / @x) * 100
  end

  def withdrawcreate
    @user = User.find(current_user)
    @bankaccount = BankAccountInfo.find(current_user.bank_account_info)
    @withdraw = Transaction.new(withdraw_params)
    @totalamt=  Transaction.select("transacted_amount").where(user_id: current_user).sum("transacted_amount")
    if @withdraw.transacted_amount.blank?
      flash[:notice] = 'Please enter a valid amount'
      redirect_to transactions_withdraw_path

    elsif @bankaccount.account_no.blank?
      flash[:notice] = 'Please key in your bank details'
      redirect_to profileaccount_path

    elsif @totalamt < @withdraw.transacted_amount
      flash[:notice] = 'Sorry but your withdrawal amount exceeds your total savings amount. Please enter a valid withdrawal amount'
      redirect_to transactions_withdraw_path
    else
      @withdraw.transacted_amount = @withdraw.transacted_amount * -1
      @bank = BankAccountInfo.find(current_user.bank_account_info)
      @withdraw.bank_account_info_id = @bank.id
      @user = User.find(current_user)
      @withdraw.transacted_date = DateTime.now.to_date
      @withdraw.user_id = @user.id
      @withdraw.save
      flash[:notice] = 'We will process your withdrawal request within 3 working days.'
      redirect_to transactions_path
    end
  end

  private

  def transaction_params
    puts params.require(:transaction).inspect
    params.require(:transaction).permit(:transacted_amount, :transacted_date, :transaction_no)
  end

  def withdraw_params
    params.require(:withdraw).permit(:transacted_amount, :transacted_date, :transaction_no)

  end
end
