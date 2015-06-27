module Eugeneral
  class Command
    attr_reader :command

    def initialize(command)
      @command = command
    end

    def resolve
      command.resolve
    end
  end
end