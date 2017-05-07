class TransactionsController < ApplicationController

def index
  @user = User.find(current_user)
@sumofmoney = Transaction.select("transacted_amount", "transacted_date", "created_at").where(
user_id: current_user.id
)

end

# def date
# @date = Transaction.find(created_at: :from)
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

  def withdraw
    @withdraw = Transaction.new(withdraw_params)
    @bank = BankAccountInfo.find(current_user.bank_account_info)
    @withdraw.bank_account_info_id = @bank.id
    @user = User.find(current_user)
    @withdraw.user_id = @user.id
    @withdraw.save
      redirect_to transactions_path
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
