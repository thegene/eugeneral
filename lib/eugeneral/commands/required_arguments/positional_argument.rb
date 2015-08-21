module Eugeneral
  module RequiredArguments
    class PositionalArgument < Argument
      def resolve(args=[])
        args[target] || not_found
      end
    end
  end
end