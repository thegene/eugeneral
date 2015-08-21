module Eugeneral
  module ArgumentsWithDefault
    class NamedArgument < Argument

      def resolve(args={})
        args[target.to_sym] || args[target.to_s] || default
      end
    end
  end
end
