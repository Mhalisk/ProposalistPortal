module EncorDividend
  extend ActiveSupport::Concern

  def run_encor_dividend()
    job_to_run = @job.job_link
    EncorSolarDividendJob.perform_later(job_to_run)
  end

  def run_encor_service_finance
    puts 'Service finance has been ran'
  end

end