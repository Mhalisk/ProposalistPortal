module EncorDividend
  extend ActiveSupport::Concern

  def run_encor_dividend
    `cd #{Rails.root} && rake encor_solar:dividend --trace`
    puts "You have ran run_encor_dividend"
  end

end