module Representers
  module JSONHash
    class Customer
      def call(customer)
        {
          token: customer.token,
          email: customer.email,
          first_name: customer.first_name,
          last_name: customer.last_name,
          phone_number: customer.phone_number,
          company: customer.company,
          notes: customer.notes,
          created_at: customer.created_at,
          card: customer.card
        }
      end
    end
  end
end
