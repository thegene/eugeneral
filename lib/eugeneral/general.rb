module Eugeneral
  class General

    def command(command, proc)
      define_singleton_method(command) do |*args, **kwargs|
        if no_args?(args, kwargs)
          proc.call
        elsif kwargs_only?(args, kwargs)
          proc.call(kwargs)
        else
          proc.call(args_from_both(args, kwargs))
        end
      end
    end

    private

    def no_args?(args, kwargs)
      args.empty? && kwargs.empty?
    end

    def args_from_both(args, kwargs)
      [].tap { |parsed_args|
        parsed_args.push(*args) unless args.empty?
        parsed_args << kwargs unless kwargs.empty?
      }.flatten
    end

    def kwargs_only?(args, kwargs)
      args.empty? && !kwargs.empty?
    end

  end
end
