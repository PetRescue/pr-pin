module PR
  module Pin
    module Repositories
      module Concerns
        module Common
          def create(*args)
            API::Result.wrap(root) do
              root.command(:create).call(*args)
            end
          end

          def list(page: 1, per_page: nil)
            API::Result.wrap(root) do
              root.with_params(
                page: page,
                per_page: per_page
              ).paginate
            end
          end
        end
      end
    end
  end
end
