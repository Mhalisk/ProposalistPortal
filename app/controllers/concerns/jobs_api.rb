require 'uri'
require 'cgi'

module JobsApi
  extend ActiveSupport::Concern
  
  # This parses the URL for the query params to autofil the new job creation
  def url_parser
    uri = request.original_url    
    params = CGI::parse( URI::parse(uri).query )
    @first_name = params["first_name"]
    @last_name = params["last_name"]
    @address = params["address"]
    @city = params["city"]
    @state = params["state"]
    @zip = params["zip"]
    @email = params["email"]
    @phone_number = params["phone_number"]
    @ssn = params["ssn"]
    @annual_income = params["annual_income"]
    @mortgage_payment = params["mortgage_payment"]
    @lending_partner = params["lending_partner"]
  end
end