module Eugeneral
  module DSL
    class Vocabulary
      attr_reader :mapping

      def initialize(mapping)
        @mapping = normalize_mapping(mapping)
      end

      def define(command, *args)
        command_instance(command, args) if has_command?(command)
      end

      private

      def normalize_mapping(mapping)
        Hash[mapping.map{ |k, v| [k.to_sym, v] }]
      end

      def command_instance(command, args)
        if args.any?
          find_command(command).new(*args)
        else
          find_command(command).new
        end
      end

      def find_command(command)
        mapping[command.to_sym]
      end

      def has_command?(command)
        mapping.has_key?(command.to_sym)
      end
    end
  end
end
