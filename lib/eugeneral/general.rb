module Eugeneral
  class General

    def command(command, proc)
      @command_list ||= {}
      @command_list[command.to_sym] = proc
    end

    def method_missing(method, *args, &block)
      @command_list[method].call(*args, &block) if @command_list[method]
    end
  end
end
