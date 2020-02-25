module PR
  module Pin
    module Repositories
      class Charges < ROM::Repository[:charges]
        include Concerns::Common

        def search(**params)
          relation = root.append_path('search').with_params(params)

          API::PaginatedResult.wrap(relation) do
            relation.paginate
          end
        end
      end
    end
  end
end
