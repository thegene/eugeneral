module Eugeneral
  class Command
    include Eugeneral::Value

    attr_reader :command

    def initialize(command)
      @command = command
    end

    def resolve(args=[])
      value_for command, args
    end
  end
end