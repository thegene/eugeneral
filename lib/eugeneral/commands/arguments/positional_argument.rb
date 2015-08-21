module Eugeneral
  module Arguments
    class PositionalArgument < Argument
      def resolve(args=[])
        args[target] || not_found
      end
    end
  end
end