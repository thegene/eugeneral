module Eugeneral
  module RequiredArguments
    class PositionalArgument < Argument
      def resolve(args=[])
        args[target].tap { |value|
          not_found if Array(value).empty?
        }
      end

    end
  end
end