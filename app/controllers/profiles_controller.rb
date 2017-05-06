class ProfilesController < ApplicationController
before_action :authenticate_user!

def index
  @user = User.find(current_user)
end

def edit
  @user = User.find(current_user)
  @income = Income.where(user_id: current_user.id)[0]

end

def update
  @user = User.find(current_user)
  @user.update(user_params)

  redirect_to edit_profile_path
end

def bankaccount
  @user = User.find(current_user)
  @bank = BankAccountInfo.where(user_id: current_user.id)[0]
  @bank_array = %w(DBS POSB)
end

def updatebankdetails

  @income = BankAccountInfo.where(user_id: current_user.id)
  @income.update(bank_account_info_params)
  flash[:notice] = "You have updated your bank details! Your bank details will be verified within the next 3 days."

  redirect_to profileaccount_path

end

private

def user_params
  params.require(:user).permit(:first_name, :last_name, :id_no, :dob, :gender, :nationality, :address, :country, :postal_code, :mobile_no)
end

def bank_account_info_params

  params.require(:bank_account_info).permit(:bank_name, :bank_currency, :account_no, :name_on_account, :branch_code)

end

end
