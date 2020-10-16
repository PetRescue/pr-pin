module PR
  module Pin
    module Relations
      class Customers < ROM::Relation[:pr_pin]
        schema(:customers) do
          attribute :token, Types::Strict::String
          attribute :email, Types::Strict::String
          attribute :first_name, Types::Strict::String.optional
          attribute :last_name, Types::Strict::String.optional
          attribute :phone_number, Types::Strict::String.optional
          attribute :company, Types::Strict::String.optional
          attribute :notes, Types::Strict::String.optional
          attribute :created_at, Types::JSON::DateTime
          attribute :card, Types::JSON::Hash
        end
      end
    end
  end
end
