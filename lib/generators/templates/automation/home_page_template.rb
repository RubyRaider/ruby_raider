require_relative '../template'

class HomePageTemplate < Template
  def body
    <<~EOF
      require_relative '../abstract/abstract_page'

      class HomePage < AbstractPage

        #Actions

        def go_to_login
          driver.wait { login_button_navigator }.click
        end

        private

        # Elements

        def login_button_navigator
          driver.find_element(accessibility_id: 'Login Screen')
        end
      end
    EOF
  end
end