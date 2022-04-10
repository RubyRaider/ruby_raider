require_relative '../template'

class AbstractComponentTemplate < Template
  def body
    raider = if @framework == 'rspec'
               "require_relative '../../helpers/raider'"
             else
               "require_relative '../../features/support/helpers/raider'"
             end

    <<~EOF
      #{raider}

      class AbstractComponent

          def initialize(component)
            @component = component
          end
      end
    EOF
  end
end