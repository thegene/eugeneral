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
      default_arg_number: ::Eugeneral::ArgumentsWithDefault::PositionalArgument,
      greater_than: ::Eugeneral::Comparisons::GreaterThan,
      greater_than_or_equal_to: ::Eugeneral::Comparisons::GreaterThanOrEqualTo,
      less_than: ::Eugeneral::Comparisons::LessThan,
      less_than_or_equal_to: ::Eugeneral::Comparisons::LessThanOrEqualTo,
      and: ::Eugeneral::Logic::And,
      or: ::Eugeneral::Logic::Or,
      not: ::Eugeneral::Logic::Not
    }

    def self.default_vocabulary
      @default_vocabulary = Vocabulary.new(DEFAULT_MAPPING)
    end
  end
end