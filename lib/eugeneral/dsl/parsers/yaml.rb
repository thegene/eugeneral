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

        def define(thing, *args)
          vocabulary.define(thing, *args) || thing
        end

        def is_defined?(thing)
          vocabulary.defines?(thing)
        end

        def command_hash(yaml)
          YAML_LOADER.load(yaml).map { |command, args|
            [
              command.to_sym, 
              build_base_command(parse_recursive(args))
            ]
          }.to_h
        end

        def parse_recursive(args)
          case args
          when Hash
            handle_hash(args)
          when Array
            handle_array(args)
          else
            define(args)
          end
        end

        def build_base_command(commands)
          ->(args=[]) {
            Array(commands).each { |command| command.resolve(*args) }
          }
        end

        def build_struct_from(hash)
          Struct.new(*hash.keys).new(*hash.values)
        end

        def handle_hash(hash)
          key, value = hash.first

          if is_defined?(key)
            define(key, parse_recursive(value))
          else
            {}.tap do |defined|
              hash.each { |key, value|
                defined[key] = parse_recursive(value)
              }
            end
          end

        end

        def handle_array(array)
          array.map do |arg|
            parse_recursive(arg)
          end
        end

        def handle(thing)
          define(thing)
        end
      end
    end
  end
end