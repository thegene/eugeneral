module Eugeneral
  module DSL
    class Vocabulary
      attr_reader :mapping

      def initialize(mapping)
        @mapping = normalize_mapping(mapping)
      end

      def define(command, args=[])
        defines?(command) ? command_instance(command, args) : command
      end

      def defines?(command)
        mapping.has_key?(symbolize(command))
      end

      def []=(key, val)
        merge!(key => val)
      end

      def merge!(definitions)
        @mapping.merge!(normalize_mapping(definitions))
      end

      private

      def symbolize(string)
        string.to_sym if string.respond_to?(:to_sym)
      end

      def normalize_mapping(mapping)
        Hash[mapping.map{ |k, v| [k.to_sym, v] }]
      end

      def command_instance(command, args)
        if Array(args).any?
          find_command(command).new(*args)
        else
          find_command(command).new
        end
      end

      def find_command(command)
        mapping[symbolize(command)]
      end

    end
  end
end
