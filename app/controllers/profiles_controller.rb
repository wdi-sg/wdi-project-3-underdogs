class ProfilesController < ApplicationController
before_action :authenticate_user!

def index
  @user = User.find(current_user)

end

def edit
  @user = User.find(current_user)
end

def update
  @user = User.find(current_user)
    if @user.update(user_params)
      redirect_to analysis_path
    else
      render html:'ARGH'
    end
end

private

def user_params
  params.require(:user).permit(:first_name, :last_name, :id_no, :dob, :gender, :nationality, :address, :postal_code, :mobile_no)

end

end
