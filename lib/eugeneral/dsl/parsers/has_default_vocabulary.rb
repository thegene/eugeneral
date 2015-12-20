require_relative '../dsl'

module Eugeneral
  module DSL
    module Parsers
      module HasDefaultVocabulary
        def vocabulary=(vocabulary)
          @vocabulary = vocabulary
        end

        def vocabulary
          @vocabulary ||= Eugeneral::DSL.default_vocabulary
        end
      end
    end
  end
end
    