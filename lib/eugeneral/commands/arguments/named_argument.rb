module Eugeneral
  module Arguments
    class NamedArgument
      attr_reader :name

      def initialize(name)
        @name = name
      end

      def resolve(args={})
        args[name.to_sym] || args[name.to_s] || not_found
      end

      private

      def not_found
        raise ArgumentError.new("Missing argument: #{name}")
      end
    end
  end
end
