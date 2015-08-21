module Eugeneral
  module ArgumentsWithDefault
    class PositionalArgument < Argument

      def resolve(args=[])
        args[target] || default
      end
    end
  end
end
