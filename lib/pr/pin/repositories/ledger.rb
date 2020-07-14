module PR
  module Pin
    module Repositories
      class Ledger < ROM::Repository[:ledger]
        struct_namespace PR::Pin::Struct

        def for_subscription(token, page: 1, per_page: nil)
          relation = root.for_subscription(token).with_params(
            page: page,
            per_page: per_page
          )

          API::PaginatedResult.wrap(relation) { relation.paginate }
        end
      end
    end
  end
end
