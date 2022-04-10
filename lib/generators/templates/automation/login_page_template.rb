require_relative '../template'

class LoginPageTemplate < Template
  def element
    case @automation
    when 'watir' then 'browser.element'
    when 'selenium', 'appium_ios' then 'driver.find_element'
    end
  end

  def helper
    case @automation
    when 'watir' then 'using Raider::WatirHelper'
    when 'selenium' then 'using Raider::SeleniumHelper'
    else nil
    end
  end

  def require_header
    "require_relative '../components/header_component'" if %w[selenium watir].include?(@automation)
  end

  def url
    if %w[selenium watir].include?(@automation)
      <<~EOF
        def url(_page)
         'index.php?rt=account/login' 
        end
      EOF
    end
  end

  def header
    if %w[selenium watir].include?(@automation)
      <<~EOF
        # Components

            def header
              HeaderComponent.new(#{element}(class: 'menu_text'))
            end
      EOF
    end
  end

  def username_element
    selector = if %w[selenium watir].include?(@automation)
                 "(id: 'loginFrm_loginname')"
               else
                 "(xpath: \"//XCUIElementTypeTextField[@name=\\\"username\\\"]\")"
               end
    "#{element}#{selector}"
  end

  def password_element
    selector = if %w[selenium watir].include?(@automation)
                 "(id: 'loginFrm_password')"
               else
                 "(xpath: \"//XCUIElementTypeSecureTextField[@name=\\\"password\\\"]\")"
               end
    "#{element}#{selector}"
  end

  def button
    if %w[selenium watir].include?(@automation)
      "#{element}(xpath: \"//button[@title='Login']\")"
    else
      "driver.find_elements(xpath: \"//XCUIElementTypeOther[@name=\\\"loginBtn\\\"]\").last"
    end
  end

  def click
    %w[selenium watir].include?(@automation) ? 'click_when_present' : 'click'
  end

  def body
    <<~EOF
      require_relative '../abstract/abstract_page'
      #{require_header}

      class LoginPage < AbstractPage
        #{helper}

        #{url}

        # Actions

        def login(username, password)
          username_field.send_keys username
          password_field.send_keys password
          login_button.#{click}
        end

        #{header}

        private

        # Elements

        def username_field
          #{username_element}
        end

        def password_field
          #{password_element}
        end

        def login_button
          #{button}
        end
      end
    EOF
  end
end