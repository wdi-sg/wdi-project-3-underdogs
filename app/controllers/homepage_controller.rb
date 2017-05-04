class HomepageController < ApplicationController

def homepage
  @user = User.find(current_user)
end

def publicanalysis

end

end
