class EncorSolarController < ApplicationController
  include EncorDividend
  
  def home
  end

  def run_encor_dividend
    `cd #{Rails.root} && rake encor_solar:dividend`
  end
end
