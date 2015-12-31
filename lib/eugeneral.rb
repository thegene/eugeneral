require_relative 'eugeneral/version'
require_relative 'eugeneral/commands/commands'
require_relative 'eugeneral/dsl/dsl'

module Eugeneral
  DEFAULT_PARSER = Eugeneral::DSL::Parsers::YAML

  def self.general(command_list, args={})
    parser_from(args).parse(command_list)
  end

  def self.parser_from(args)
    args[:parser] || DEFAULT_PARSER.new
  end
end
