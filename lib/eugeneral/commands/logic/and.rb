module Eugeneral
  module Logic
    class And
      include Eugeneral::Value

      attr_reader :expressions

      def initialize(*expressions)
        @expressions = expressions
      end

      def resolve(args=nil)
        expressions.all? { |e| value_for(e, args) }
      end
    end
  end
end