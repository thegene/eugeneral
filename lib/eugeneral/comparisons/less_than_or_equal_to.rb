module Eugeneral
  module Comparisons
    class LessThanOrEqualTo < Comparitor

      def resolve(args=[])
        value_for(subject, args) <= value_for(object, args)
      end
      
    end
  end
end
