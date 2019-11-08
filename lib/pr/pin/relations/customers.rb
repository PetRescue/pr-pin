module PR
  module Pin
    module Relations
      class Customers < ROM::Relation[:pr_pin]
        schema(:customers) do
          attribute :token, Types::Strict::String
          attribute :email, Types::Strict::String
          attribute :created_at, Types::JSON::DateTime
          attribute :card, Types::JSON::Hash
        end
      end
    end
  end
end
