class TransactionsController < ApplicationController

def new
  @transaction = Transaction.new
end

def create
  puts "params"
  @transaction = Transaction.new(transaction_params)
  puts @transaction.inspect
  @bank = BankAccountInfo.find(current_user.bank_account_info)
  @transaction.bank_account_info_id = @bank.id
  @user = User.find(current_user)
  @transaction.user_id = @user.id
  if @transaction.save
    redirect_to root_path
  else
    render :new
  end
end

  def createstripe
    @amount = params[:amount]

     @amount = @amount.gsub('$', '').gsub(',', '')

     begin
       @amount = Float(@amount).round(2)
     rescue
       flash[:error] = 'Charge not completed. Please enter a valid amount in USD ($).'
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
       :currency => 'usd',
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
        redirect_to root_path
      else
        flash
      end


     rescue Stripe::CardError => e
       flash[:error] = e.message
       redirect_to new_charge_path
  end

  def topup
    @topup = Transaction.new
    @topup.save
  end

  def withdraw
    @withdraw = Transaction.new
    @withdraw.save
  end

  def history

  end

  private

  def transaction_params
    puts params.require(:transaction).inspect
    params.require(:transaction).permit(:transacted_amount, :transacted_date, :transaction_no)
  end
end
