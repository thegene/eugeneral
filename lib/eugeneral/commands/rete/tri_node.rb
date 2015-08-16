module Eugeneral
  module Rete
    class TriNode
      include Eugeneral::Value

      attr_reader :nodes

      def initialize(nodes)
        @nodes = nodes
      end

      def resolve(args=[])
        nodes.lazy.map { |node|
          value_for(node, args)
        }.reject { |node|
          node.nil? || node == false
        }.first
      end

    end
  end
end
