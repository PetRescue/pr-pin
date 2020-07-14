module PR
  module Pin
    module Repositories
      class Charges < ROM::Repository[:charges]
        include Concerns::Common

        def find(token)
          relation = root.with_path(token)

          API::Result.wrap(relation) { relation.one }
        end

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
