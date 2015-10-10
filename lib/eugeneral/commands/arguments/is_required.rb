module Eugeneral
  module Arguments
    module IsRequired
      attr_reader :target

      def initialize(target)
        @target = target
      end

      protected

      def not_found
        raise ArgumentError.new("Missing argument: #{target}")
      end
    end
  end
end
