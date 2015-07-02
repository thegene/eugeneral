module Eugeneral
  class Command
    attr_reader :command

    def initialize(command)
      @command = command
    end

    def resolve(*args)
      command.resolve(*args)
    end
  end
end