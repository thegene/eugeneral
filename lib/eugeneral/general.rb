module Eugeneral
  class General

    def command(command, proc)
      define_singleton_method(command) do |*args|
        proc.call(*args)
      end
    end

  end
end
