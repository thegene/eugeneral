module Eugeneral
  module Arguments
    class RequiredNamed < Named
      include IsRequired
    end
  end
end
