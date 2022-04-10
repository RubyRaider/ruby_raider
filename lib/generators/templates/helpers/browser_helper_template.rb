require_relative '../template'

class BrowserHelperTemplate < Template
  def body
    <<~EOF
      require 'yaml'
      require 'selenium-webdriver'
      require 'watir'
      require 'webdrivers'

      module Raider
        module BrowserHelper
          class << self
            attr_reader :browser

            def new_browser
              config = YAML.load_file('config/config.yml')
              @browser = Watir::Browser.new config['browser']
            end
          end
        end
      end

    EOF
  end
end