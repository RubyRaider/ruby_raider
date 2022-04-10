require_relative '../template'

class EnvTemplate < Template
  def body

    if @automation == 'watir'
      helper = 'helpers/browser_helper'
      browser = 'Raider::BrowserHelper.new_browser'
      get_browser = 'browser = Raider::BrowserHelper.new_browser'
      screenshot = 'browser.screenshot.save("allure-results/screenshots/#{scenario.name}.png")'
      quit = 'browser.quit'
    else
      helper = 'helpers/driver_helper'
      browser = 'Raider::DriverHelper.new_driver'
      get_browser = 'driver = Raider::DriverHelper.driver'
      screenshot = 'driver.save_screenshot("allure-results/screenshots/#{scenario.name}.png")'
      quit = 'driver.quit'
    end

    <<~EOF
      require 'active_support/all'
      require_relative 'helpers/allure_helper'
      require_relative '#{helper}'

      Before do
          Raider::AllureHelper.configure
          #{browser}
      end

      After do |scenario|
       #{get_browser}
        #{screenshot}
        Raider::AllureHelper.add_screenshot(scenario.name)
        #{quit}
      end
    EOF
  end
end