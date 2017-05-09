class HomepageController < ApplicationController

  def homepage
    @user = User.new
  end

  def publicanalysis
    @user = User.new
  end

end
