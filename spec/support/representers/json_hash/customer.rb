module Representers
  module JSONHash
    class Customer
      def call(customer)
        {
          token: customer.token,
          email: customer.email,
          created_at: customer.created_at,
          card: customer.card
        }
      end
    end
  end
end
