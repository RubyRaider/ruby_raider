require_relative '../template'

class ConfirmationPageTemplate < Template
  def body
    <<~EOF
      require_relative '../abstract/abstract_page'

      class ConfirmationPage < AbstractPage

        #Values

        def login_message
          driver.wait { message_element }.text
        end

        private

        # Elements

        def message_element
          driver.find_element(accessibility_id: 'You are logged in as alice')
        end
      end
    EOF
  end
end