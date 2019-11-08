module PR
  module Pin
    module Adapter
      class Relation < ROM::HTTP::Relation
        adapter :pr_pin

        def input_schema
          ROM::Command.input
        end
      end
    end
  end
end
