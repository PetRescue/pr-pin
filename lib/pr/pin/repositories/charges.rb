module PR
  module Pin
    module Repositories
      class Charges < ROM::Repository[:charges]
        struct_namespace PR::Pin::Struct

        def create(*args)
          API::Result.wrap(root) do
            root.command(:create).call(*args)
          end
        end

        def find(token)
          relation = root.with_path(token)

          API::Result.wrap(relation) { relation.one }
        end

        def list(page: 1, per_page: nil)
          relation = root.with_params(
            page: page,
            per_page: per_page
          )

          API::PaginatedResult.wrap(relation) { relation.paginate }
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
