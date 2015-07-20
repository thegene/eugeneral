module Eugeneral
  module Comparisons
    class Equal
      include Eugeneral::Value

      attr_reader :subject, :object

      def initialize(subject, object)
        @subject, @object = subject, object
      end

      def resolve(args)
        value_for(subject, args) == value_for(object, args)
      end
    end
  end
end