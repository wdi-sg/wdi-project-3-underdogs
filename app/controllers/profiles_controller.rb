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
  @bank_account_info = BankAccountInfo.new()
end

def addbankdetails
  @bank_account_info = BankAccountInfo.new(bank_account_info_params)
  @bank_account_info.user_id = current_user.id
  @bank_account_info.save

  redirect_to profileaccount_path

end

private

def user_params
  params.require(:user).permit(:first_name, :last_name, :id_no, :dob, :gender, :nationality, :address, :postal_code, :mobile_no)
end

def bank_account_info_params

  params.require(:bank_account_info).permit(:bank_name, :bank_currency, :account_no, :name_on_account, :branch_code)

end

end
