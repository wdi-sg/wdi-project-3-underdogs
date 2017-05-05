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
    #puts params.require(:transaction).inspect
    #params.require(:transaction).permit(:transacted_amount, #:transacted_date, :transaction_no)
  end
end
