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

  def find_element_with_wait(what, time = 25) 
    wait = Selenium::WebDriver::Wait.new(timeout: time) 
    wait.until { 
      element = @driver.find_element(what)
    }
  end

  def setup()
    # To switch between normal and headless remove headless option from array and delete headless part of :headless_chrome
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
    caps = Selenium::WebDriver::Remote::Capabilities.chrome(page_load_strategy: 'none')
    @driver = Selenium::WebDriver.for :chrome, desired_capabilities: caps
    Capybara.javascript_driver = :headless_chrome
    puts "Driver has been instanciated..."
    start_encor_service_finance('https://apply.svcfin.com/')
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
  end

  # Service Finance Logic

  def start_encor_service_finance(url)
    @driver.navigate.to(url)
    puts "Successfully navigated to Service Finance..."
    write_things('//*[@id="dealerNumber"]', '585125335')
    find_element_with_wait(xpath: '//*[@id="dealerLookUp"]').click
    puts "Successfully validated dealer code..."
    if find_element_with_wait(xpath: '//*[@id="BizValidator"]/label[1]/input').attribute('value') == 'SOLAR EQUIPMENT' 
      @driver.find_element(:css => "#BizValidator > label:nth-child(1) > span").click 
    elsif find_element_with_wait(xpath: '//*[@id="BizValidator"]/label[2]/input').attribute('value') == 'SOLAR EQUIPMENT' 
      @driver.find_element(:css => "#BizValidator > label:nth-child(2) > span").click 
    else find_element_with_wait(xpath: '//*[@id="BizValidator"]/label[3]/input').attribute('value') == 'SOLAR EQUIPMENT' 
      @driver.find_element(:css => "#BizValidator > label:nth-child(3) > span").click 
    end
    puts "We are waiting for the magic"
    find_element_with_wait(xpath: '//*[@id="submitDealer"]').click
    @driver.get('https://apply.svcfin.com/home/goToResidentialLoan')

    fill_out_sales_person_info('Jon Snow', '8019136969', 'jonsnow@gmail.com')
  end

  def fill_out_sales_person_info(sales_person_name, sales_person_phone, sales_person_email)
    write_things('//*[@id="salesName"]', sales_person_name)
    write_things('//*[@id="Salesman_Phone"]', sales_person_phone)
    write_things('//*[@id="Salesman_Email"]', sales_person_email)
    puts 'We filled that shit out BOOIIIII'
  end
end