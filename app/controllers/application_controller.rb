class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # check to show notif if sign_in_count > 2
  before_action :check_for_notificiations

  def check_for_notificiations
    # populate your flash data
  end

end
