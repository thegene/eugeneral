module Eugeneral
  module Comparisons
    class Comparitor
      include Eugeneral::Value

      attr_reader :subject, :object

      def initialize(subject, object)
        @subject, @object = subject, object
      end
    end
  end
end