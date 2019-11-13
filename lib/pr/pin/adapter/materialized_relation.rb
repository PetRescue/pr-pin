module PR
  module Pin
    module Adapter
      class MaterializedRelation < Relation
        def paginate
          PaginatedResponse.new(dataset.to_a, dataset.pagination_params)
        end
      end
    end
  end
end
