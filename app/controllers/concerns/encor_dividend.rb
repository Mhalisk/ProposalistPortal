module EncorDividend
  extend ActiveSupport::Concern

  def run_encor_dividend()
    # Uncomment command below to run as rake task
    # `cd #{Rails.root} && rake encor_solar:dividend`
    EncorSolarDividendJob.perform_later()
  end

end