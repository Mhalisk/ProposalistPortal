class EncorSolarDividendJob < ApplicationJob
  queue_as :default

  def perform(first_name, last_name, full_address, email, phone_number, ssn, annual_income, mortgage_payment)
    @first_name = first_name
    @last_name = last_name
    @full_address = full_address
    @email = email
    @phone_number = phone_number
    @ssn = ssn
    @annual_income = annual_income
    @mortgage_payment = mortgage_payment
    setup()
  end

  def write_things(xpath, writing)
    element = find_element_with_wait(xpath: xpath)
    element.send_keys(writing)
  end

  def find_element_with_wait(what, time = 25) 
    wait = Selenium::WebDriver::Wait.new(timeout: time) 
    wait.until { 
      element = @driver.find_element(what)
    }
  end

  def setup()
    # To switch between normal and headless add/remove headless option from array and add/remove headless part of :headless_chrome
    chrome_bin = ENV.fetch('GOOGLE_CHROME_SHIM', nil)
    options = {}
    options[:args] = ['headless', 'disable-gpu', 'window-size=1280,1024']
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
    start_dividend()
  end
  
  def close_browser()
    @driver.quit()
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
    find_element_with_wait(xpath: '//*[@id="CLb1"]').click
    puts "Adding a new homeowner"
    sleep 2
    write_things('//*[@id="AFy"]', @first_name)
    write_things('//*[@id="AGE"]', @last_name)
    write_things('//*[@id="AGT"]/span/input[2]', @full_address)
    write_things('//*[@id="AGZ"]', @phone_number)
    write_things('//*[@id="AGW"]', @email)
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
    write_things('//*[@id="aAcmm"]', @ssn.last(4))
    find_element_with_wait(xpath: '//*[@id="Dos"]').click
    sleep 10
    puts "Credit check has been successful..."
    puts "All dividend processes have been completed SUCCESSFULLY"
    close_browser()
  end
end
