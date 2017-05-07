class TransactionsController < ApplicationController

def index
  @user = User.find(current_user)
@sumofmoney = Transaction.select("transacted_amount", "transacted_date").where(
user_id: current_user.id
)
@total=  Transaction.select("transacted_amount").where(user_id: current_user).sum("transacted_amount")
@date = Transaction.select("created_at").where("created_at >?", 2/4/2017 )
end

# def date
# @date = Transaction.select("created_at").where("created_at >?", :from )
# end

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
  @transaction.save
    redirect_to transactions_path
  # else
  #   render :new
  # end

end

def withdrawnew
  @user = User.find(current_user)
  @withdraw = Transaction.new()
end
  def withdrawcreate
    @withdraw = Transaction.new(withdraw_params)
    @totalamt=  Transaction.select("transacted_amount").where(user_id: current_user).sum("transacted_amount")
    if @totalamt < @withdraw.transacted_amount
      flash[:notice] = 'fuck you'
      redirect_to transactions_withdraw_path
    else
    @withdraw.transacted_amount = @withdraw.transacted_amount * -1
    @bank = BankAccountInfo.find(current_user.bank_account_info)
    @withdraw.bank_account_info_id = @bank.id
    @user = User.find(current_user)
    @withdraw.user_id = @user.id
    @withdraw.save
      redirect_to transactions_withdraw_path
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
