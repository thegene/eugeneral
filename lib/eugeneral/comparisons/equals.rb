module Eugeneral
  module Comparisons
    class Equals
      attr_accessor :expected, :actual

      def initialize(expected, actual)
        @expected, @actual = expected, actual
      end

      def resolve(*args)
        expected.resolve(*args) == actual.resolve(*args)
      end
    end
  end
end