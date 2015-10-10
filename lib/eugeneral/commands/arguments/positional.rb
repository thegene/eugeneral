module Eugeneral
  module Arguments
    class Positional

      def resolve(args=[])
        if args.count > target
          args[target]
        else
          not_found
        end
      end

    end
  end
end
