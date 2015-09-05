module Eugeneral
  class General

    def command(command, proc)
      @command_list ||= {}
      @command_list[command] = proc
    end

    def method_missing(method, *args, &block)
      @command_list[method].call(*args) if @command_list[method]
    end
  end
end
