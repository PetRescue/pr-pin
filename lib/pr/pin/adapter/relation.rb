module PR
  module Pin
    module Adapter
      class Relation < ROM::HTTP::Relation
        adapter :pr_pin

        def paginate
          materialized = dataset.materialize

          raise(
            NoPaginationError,
            dataset.uri
          ) unless materialized.paginates?

          MaterializedRelation.new(materialized).paginate
        end

        def input_schema
          ROM::Command.input
        end
      end
    end
  end
end
