require 'yaml'

module Eugeneral
  module DSL
    module Parsers
      class YAML
        attr_accessor :vocabulary

        YAML_LOADER = ::YAML

        def initialize(vocabulary)
          @vocabulary = vocabulary
        end

        def parse(yaml)
          build_struct_from(command_hash(yaml))
        end

        private

        def command_hash(yaml)
          YAML_LOADER.load(yaml).map { |command, args|
            [command.to_sym, command_from(args)]
          }.to_h
        end

        def command_from(args)
          command = args.keys.first
          vocabulary.define(command, args[command])
        end

        def build_struct_from(hash)
          Struct.new(*hash.keys).new(*hash.values)
        end
      end
    end
  end
end