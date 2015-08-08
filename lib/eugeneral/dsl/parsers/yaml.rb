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
            [command.to_sym, build_base_command(recurse_args_for_commands(args))]
          }.to_h
        end

        def recurse_args_for_commands(args)
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
          [].tap do |commands|
            hash.keys.each do |key|
              args = recurse_args_for_commands(hash[key])
              if is_defined?(key)
                commands << define(key, args)
              else
                commands << { key => args }
              end
            end
          end
        end

        def handle_array(array)
          array.map do |arg|
            recurse_args_for_commands(arg)
          end
        end

        def handle(thing)
          define(thing)
        end
      end
    end
  end
end