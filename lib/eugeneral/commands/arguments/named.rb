module Eugeneral
  module Arguments
    class Named

      def resolve(args)
        case
        when present?(args, target.to_sym)
          args[target.to_sym]
        when present?(args, target.to_s)
          args[target.to_s]
        else
          not_found
        end
      end

      private

      def present?(args, key)
        args.respond_to?(:has_key?) && args.has_key?(key)
      end
    end
  end
end
