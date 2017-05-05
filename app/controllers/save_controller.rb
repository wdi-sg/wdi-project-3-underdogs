class SaveController < ApplicationController

  def save

  end

  def topup
    @client_token = Braintree::ClientToken.generate
    puts "****************************************"
    puts @client_token
  end

  def withdraw
  end

  def history
  end
end
