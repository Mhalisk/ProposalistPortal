class EncorSolarDividendJob < ApplicationJob
  queue_as :default

  def perform(*args)
    start_encor_dividend()
  end

  def start_encor_dividend()
    # To switch between normal and headless remove headless option from array and delete headless part of :headless_chrome

    chrome_bin = ENV.fetch('GOOGLE_CHROME_SHIM', nil)

    options = {}
    options[:args] = ['headless','disable-gpu', 'window-size=1280,1024']
    options[:binary] = chrome_bin if chrome_bin
  
    Capybara.register_driver :headless_chrome do |app|
      Capybara::Selenium::Driver.new(app,
         browser: :chrome,
         options: Selenium::WebDriver::Chrome::Options.new(options)
       )
    end
  
    Capybara.javascript_driver = :headless_chrome

    @driver = Selenium::WebDriver.for :chrome, options: options
    
    puts "Driver has been instanciated..."

    setup('https://phoenix.encorsolar.com')
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

  def setup(url)
    @driver.navigate.to(url)

    puts "Setup method has been completed..."

    login_to_phx()
  end
  
  def close_browser()
    @driver.quit()
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
    @job = 'https://phoenix.encorsolar.com/customers/lead_details/NTM1MTU%3D'
    @driver.manage.window.maximize
    @driver.navigate.to(@job)

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
    start_dividend()
  end

  # Dividend Logic

  def start_dividend
    @driver.manage.window.maximize
    @driver.navigate.to('https://partner.solar/?_ga=2.258645962.1171827090.1516652684-1601784883.1516652684')

    puts "Successfully navigated to Dividend..."

    login_to_dividend()
  end

  def login_to_dividend()
    find_element_with_wait(xpath: '//*[@id="installerselectbutton"]').click
    write_things('//*[@id="emailinput"]', ENV["DIVIDEND_EMAIL"])
    write_things('//*[@id="passwordinput"]', ENV["DIVIDEND_PASSWORD"])
    find_element_with_wait(xpath: '//*[@id="loginbutton"]').click

    puts "Successfully logged into Dividend..."

    add_new_home_owner()
  end

  def add_new_home_owner()
    puts "Adding a new homeowner"

    find_element_with_wait(xpath: '//*[@id="CLb1"]').click
    write_things('//*[@id="AFy"]', @first_name)
    write_things('//*[@id="AGE"]', @last_name)
    write_things('//*[@id="AGT"]/span/input[2]', @full_address)
    write_things('//*[@id="AGW"]', @email)
    write_things('//*[@id="AGZ"]', @phone)
    find_element_with_wait(xpath: '//*[@id="Dru"]').click
    find_element_with_wait(xpath: '//*[@id="DoA"]').click

    puts "Successfully added a new homeowner..."

    dividend_credit_check()
  end

  def dividend_credit_check()
    # DO NOT TOUCH THIS
    puts "You've reached credit check..."
    wait = Selenium::WebDriver::Wait.new(timeout: 10)
    wait.until { @driver.find_element(xpath: '//*[@id="Dop"]').displayed? }
    write_things('//*[@id="Dop"]', @annual_income)
    write_things('//*[@id="Doq"]', @mortgage_payment)

    wait.until { @driver.find_element(xpath: '//*[@id="aAcmq"]').displayed? }
    find_element_with_wait(xpath: '//*[@id="DpQ"]').click
    write_things('//*[@id="aAcmm"]', @ssn)
    find_element_with_wait(xpath: '//*[@id="Dos"]').click
    sleep 10

    puts "Credit check has been successful..."

    puts "All dividend processes have been completed SUCCESSFULLY"
  end
end
