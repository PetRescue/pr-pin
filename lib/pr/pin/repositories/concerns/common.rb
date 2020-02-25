module PR
  module Pin
    module Repositories
      module Concerns
        module Common
          def self.included(mod)
            mod.struct_namespace(PR::Pin::Struct)
          end

          def create(*args)
            API::Result.wrap(root) do
              root.command(:create).call(*args)
            end
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
end
