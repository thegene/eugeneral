module Eugeneral
  module Logic
    class Or
      include Eugeneral::Value

      attr_reader :expressions

      def initialize(*expressions)
        @expressions = expressions
      end

      def resolve(args=[])
        expressions.any? { |e| value_for(e, args) == true }
      end
    end
  end
end