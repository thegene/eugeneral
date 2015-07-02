module Eugeneral
  module Comparisons
    class Not
      attr_reader :command

      def initialize(command)
        @command = command
      end

      def resolve(*args)
        !command.resolve(*args)
      end
    end
  end
end
