module EncorDividend
  extend ActiveSupport::Concern

  def run_encor_dividend()
    job_to_run = @job.job_link
    EncorSolarDividendJob.perform_later(job_to_run)
  end

end