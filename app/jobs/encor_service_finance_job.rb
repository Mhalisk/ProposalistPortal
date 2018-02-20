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
  end

end
