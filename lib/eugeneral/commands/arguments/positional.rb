module Eugeneral
  module Arguments
    class Positional

      def resolve(args=[])
        Array(args[target]).empty? ? not_found : args[target]
      end

    end
  end
end
