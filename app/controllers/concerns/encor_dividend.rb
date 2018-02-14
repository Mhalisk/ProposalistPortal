module EncorDividend
  extend ActiveSupport::Concern

  def run_encor_dividend
    render 'encor_solar/run_encor_dividend.html.erb'
    puts "Custom render was rendered"
    `cd #{Rails.root} && rake encor_solar:dividend --trace`
  end

end