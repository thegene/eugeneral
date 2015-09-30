require_relative 'vocabulary'
[
  'yaml'
].each { |f| require_relative File.join('parsers', f) }

module Eugeneral
  module DSL
    DEFAULT_MAPPING = {
      equals: ::Eugeneral::Comparisons::Equal
    }

    def self.default_vocabulary
      @default_vocabulary = Vocabulary.new(DEFAULT_MAPPING)
    end
  end
end