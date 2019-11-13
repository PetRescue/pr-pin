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

          PaginatedResponse.new(
            new(materialized).to_a,
            materialized.pagination_params
          )
        end

        def input_schema
          ROM::Command.input
        end
      end
    end
  end
end
