module PR
  module Pin
    module Repositories
      class Subscriptions < ROM::Repository[:subscriptions]
        include Concerns::Common

        def find(token)
          API::Result.wrap(root) do
            root.append_path(token).one
          end
        end
      end
    end
  end
end
