module Eugeneral
  module Value
    def value_for(command, *args)
      if command.respond_to?(:resolve)
        command.resolve(*args)
      else
        command
      end
    end
  end
end