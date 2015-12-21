require_relative 'vocabulary'
[
  'yaml'
].each { |f| require_relative File.join('parsers', f) }

module Eugeneral
  module DSL
    DEFAULT_MAPPING = {
      equal: ::Eugeneral::Comparisons::Equal,
      not_equal: ::Eugeneral::Comparisons::NotEqual,
      arg_number: ::Eugeneral::Arguments::RequiredPositional,
      arg_name: ::Eugeneral::Arguments::RequiredNamed,
      default_arg_number: ::Eugeneral::Arguments::PositionalWithDefault,
      default_arg_name: ::Eugeneral::Arguments::NamedWithDefault,
      greater_than: ::Eugeneral::Comparisons::GreaterThan,
      greater_than_or_equal_to: ::Eugeneral::Comparisons::GreaterThanOrEqualTo,
      less_than: ::Eugeneral::Comparisons::LessThan,
      less_than_or_equal_to: ::Eugeneral::Comparisons::LessThanOrEqualTo,
      and: ::Eugeneral::Logic::And,
      or: ::Eugeneral::Logic::Or,
      not: ::Eugeneral::Logic::Not,
      tri_node: ::Eugeneral::Rete::TriNode
    }

    def self.default_vocabulary
      @default_vocabulary ||= Vocabulary.new(DEFAULT_MAPPING)
    end
  end
end