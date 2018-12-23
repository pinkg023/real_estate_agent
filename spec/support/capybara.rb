require 'capybara/rspec'
require 'capybara/rails'

Capybara.default_max_wait_time = 20

port = rand(3001..60000)
# define server port
Capybara.server_port = port

# define browser go to where (with port)
# host name use 'localhost' for Domain <-> Agent Mapping Testing
# spec/features/user_register_spec.rb
Capybara.app_host = "http://localhost:#{port}"

# :selenium :selenium_chrome and :selenium_chrome_headless are also registered
Capybara.register_driver :chrome_headless do |app|
  # Selenium::WebDriver.logger.level = :debug
  options = Selenium::WebDriver::Chrome::Options.new(
    args: %w( headless disable-gpu no-sandbox disable-dev-shm-usage window-size=1300,800 )
  )
  client = Selenium::WebDriver::Remote::Http::Default.new
  # need to setup *timeout longer because Gitlab Runner initial very SLOW
  client.open_timeout = 20
  client.read_timeout = 20
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options, http_client: client)
end

Capybara.javascript_driver = :selenium_chrome

# class ActionDispatch::IntegrationTest
#   # Make the Capybara DSL available in all integration tests
#   include Capybara::DSL
#   # Make `assert_*` methods behave like Minitest assertions
#   include Capybara::Minitest::Assertions

#   # Reset sessions and driver between tests
#   # Use super wherever this method is redefined in your individual test classes
#   def teardown
#     Capybara.reset_sessions!
#     Capybara.use_default_driver
#   end
# end
