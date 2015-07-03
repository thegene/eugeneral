module Eugeneral
  module Comparisons
    class LessThanOrEqualTo
      attr_reader :subject, :object

      def initialize(subject, object)
        @subject, @object = subject, object
      end

      def resolve(*args)
        subject.resolve(*args) <= object.resolve(*args)
      end
    end
  end
end
