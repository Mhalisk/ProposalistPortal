class EncorServiceFinanceJob < ApplicationJob
  queue_as :default

  def perform(job_to_run)
    @job_to_run = job_to_run
    setup()
  end

  def write_things(xpath, writing)
    element = find_element_with_wait(xpath: xpath)
    element.send_keys(writing)
  end

  def find_element_with_wait(what, time = 5) 
    wait = Selenium::WebDriver::Wait.new(timeout: time) 
    wait.until { 
      element = @driver.find_element(what)
    }
  end

  def setup()
    # To switch between normal and headless remove headless option from array and delete headless part of :headless_chrome
    chrome_bin = ENV.fetch('GOOGLE_CHROME_SHIM', nil)
    options = {}
    options[:args] = ['disable-gpu', 'window-size=1280,1024']
    options[:binary] = chrome_bin if chrome_bin
    Capybara.register_driver :chrome do |app|
      Capybara::Selenium::Driver.new(app,
         browser: :chrome,
         options: Selenium::WebDriver::Chrome::Options.new(options)
       )
    end
  
    Capybara.javascript_driver = :headless_chrome
    @driver = Selenium::WebDriver.for :chrome, options: options
    puts "Driver has been instanciated..."
    start_encor_service_finance('https://apply.svcfin.com/')
  end

  def start_encor_service_finance(url)
    @driver.navigate.to(url)
    puts 'Setup method has been completed...'
    login_to_phx()
  end

end

 # PHX Logic

 def login_to_phx()
  write_things('//*[@id="email"]', ENV["PHX_EMAIL"])
  write_things('//*[@id="password"]', ENV["PHX_PASSWORD"])
  find_element_with_wait(xpath: '//*[@id="login_form"]/button').click
  puts "Log into phx successful..."
  go_to_job_admin_page()
end

def go_to_job_admin_page() 
  @driver.manage.window.maximize
  @driver.navigate.to(@job_to_run)
  puts "navigated to phx admin page..."
  get_phx_admin_page_info()
end

def get_phx_admin_page_info()
  @first_name = find_element_with_wait(xpath: '//*[@id="first-name"]').attribute('value')
  @last_name = find_element_with_wait(xpath: '//*[@id="last-name"]').attribute('value')
  # @street_address = find_element_with_wait(xpath: '//*[@id="address"]').attribute('value')
  # @city = find_element_with_wait(xpath: '//*[@id="city"]').attribute('value')
  @full_address = find_element_with_wait(xpath: '//*[@id="full-address"]').attribute('value')
  @email = find_element_with_wait(xpath: '//*[@id="email"]').attribute('value')
  @phone = find_element_with_wait(xpath: '//*[@id="phone"]').attribute('value')
  puts "Information has successfully been scraped off of phx information page..."
  get_phx_pai_page_info()
end

def get_phx_pai_page_info()
  find_element_with_wait(xpath: '//*[@id="ui-id-3"]').click
  @ssn = find_element_with_wait(xpath: '//*[@id="ssn"]').attribute('value')
  @annual_income = find_element_with_wait(xpath: '//*[@id="annual-income"]').attribute('value')
  @mortgage_payment = find_element_with_wait(xpath: '//*[@id="rent-payments"]').attribute('value')

  puts "Information has successfully been scraped off of phx primary applicant info page..."

  # Start Service Finance
end
