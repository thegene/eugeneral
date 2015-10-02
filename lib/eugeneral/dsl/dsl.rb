require_relative 'vocabulary'
[
  'yaml'
].each { |f| require_relative File.join('parsers', f) }

module Eugeneral
  module DSL
    DEFAULT_MAPPING = {
      equal: ::Eugeneral::Comparisons::Equal,
      not_equal: ::Eugeneral::Comparisons::NotEqual,
      arg_number: ::Eugeneral::RequiredArguments::PositionalArgument,
      arg_name: ::Eugeneral::RequiredArguments::NamedArgument,
      greater_than: ::Eugeneral::Comparisons::GreaterThan
    }

    def self.default_vocabulary
      @default_vocabulary = Vocabulary.new(DEFAULT_MAPPING)
    end
  end
end