require_relative '../template'

class PomHelperTemplate < Template
  def body
    <<~EOF
      module Raider
        module PomHelper
          def instance
            @instance ||= new
          end

          def method_missing(message, *args, &block)
            return super unless instance.respond_to?(message)

            instance.public_send(message, *args, &block)
          end

          def respond_to_missing?(method, *_args, &block)
            instance.respond_to?(method) || super
          end
        end
      end
    EOF
  end
end