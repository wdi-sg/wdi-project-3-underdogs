class SaveController < ApplicationController

  def save

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
end
