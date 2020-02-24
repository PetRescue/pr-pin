module PR
  module Pin
    module Repositories
      class Charges < ROM::Repository[:charges]
        include Concerns::Common

        def search(**params)
          API::Result.wrap(root) do
            root.append_path('search').with_params(params).paginate
          end
        end
      end
    end
  end
end
