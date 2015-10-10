module Eugeneral
  module Arguments
    class RequiredPositional < Positional
      include IsRequired
    end
  end
end