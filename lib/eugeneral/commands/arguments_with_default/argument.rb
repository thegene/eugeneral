module Eugeneral
  module ArgumentsWithDefault
    class Argument
      attr_reader :target, :default

      def initialize(target, default)
        @target, @default = target, default
      end

    end
  end
end
