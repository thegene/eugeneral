module Eugeneral
  module Arguments
    class NamedArgument < Argument

      def resolve(args={})
        args[target.to_sym] || args[target.to_s] || not_found
      end

    end
  end
end
