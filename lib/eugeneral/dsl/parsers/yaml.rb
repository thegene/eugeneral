require 'yaml'
require_relative '../../general'

module Eugeneral
  module DSL
    module Parsers
      class YAML
        attr_accessor :vocabulary

        YAML_LOADER = ::YAML

        def initialize(args)
          @vocabulary = args[:vocabulary]
        end

        def parse(yaml)
          general = General.new
          YAML_LOADER.load(yaml).each do |command, args|
            general.command(command, proc_for_command(args))
          end
          general
        end

        private

        def is_configured?(args)
          vocabulary.defines?(args.keys.first)
        end

        def proc_for_command(definition)
          command = parse_recursive(definition)
          ->(*args) { command.resolve(*args) }
        end

        def parse_recursive(args)
          case args
          when Hash
            if is_configured?(args)
              handle_configured(args)
            else
              handle_hash(args)
            end
          when Array
            handle_array(args)
          else
            vocabulary.define(args)
          end
        end

        def handle_configured(args)
          key, value = args.first
          value = [value] if value.class != Array
          vocabulary.define(key, parse_recursive(value))
        end

        def handle_hash(hash)
          {}.tap do |h|
            hash.each { |key, value|
              h[key] = parse_recursive(value)
            }
          end

        end

        def handle_array(array)
          array.map do |arg|
            parse_recursive(arg)
          end
        end

      end
    end
  end
end