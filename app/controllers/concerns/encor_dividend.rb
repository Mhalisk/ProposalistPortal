module EncorDividend
  extend ActiveSupport::Concern

  def show_encor_dividend()
  end

  def run_encor_dividend()
    first_name = params["first_name"]
    last_name = params["last_name"]
    address = params["address"]
    city = params["city"]
    state = params["state"]
    zip = params["zip"]
    email = params["email"]
    phone_number = params["phone_number"]
    ssn = params["ssn"]
    annual_income = params["annual_income"]
    mortgage_payment = params["mortgage_payment"]
    full_address = address + ' ' + city + ', ' + state + ' ' + zip
    
    EncorSolarDividendJob.perform_later(first_name, last_name, full_address, email, phone_number, ssn, annual_income, mortgage_payment)
  end

  def run_encor_service_finance
    job_to_run = @job.job_link
    EncorServiceFinanceJob.perform_later(job_to_run)
  end
end