module Eugeneral
  module HasDefault
    attr_reader :target, :default

    def initialize(target, default)
      @target, @default = target, default
    end

    protected

    def not_found
      default
    end

  end
end
