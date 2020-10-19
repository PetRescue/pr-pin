module PR
  module Pin
    module Repositories
      class Customers < ROM::Repository[:customers]
        struct_namespace PR::Pin::Struct

        def create(*args)
          API::Result.wrap(root) do
            root.command(:create).call(*args)
          end
        end

        def update(token, *args)
          API::Result.wrap(root) do
            root.append_path(token).command(:update).call(*args)
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
      end
    end
  end
end
