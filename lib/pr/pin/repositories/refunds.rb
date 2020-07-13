module PR
  module Pin
    module Repositories
      class Refunds < ROM::Repository[:refunds]
        struct_namespace PR::Pin::Struct

        def list(page: 1, per_page: nil)
          relation = root.with_params(
            page: page,
            per_page: per_page
          )

          API::PaginatedResult.wrap(relation) { relation.paginate }
        end

        def find(token)
          relation = root.with_path(token)

          API::Result.wrap(relation) { relation.one }
        end

        def create_for_charge(token, *args)
          relation = root.for_charge(token)

          API::Result.wrap(relation) do
            relation.command(:create).call(*args)
          end
        end

        def for_charge(token, page: 1, per_page: nil)
          relation = root.for_charge(token).with_params(
            page: page,
            per_page: per_page
          )

          API::PaginatedResult.wrap(relation) { relation.paginate }
        end
      end
    end
  end
end
