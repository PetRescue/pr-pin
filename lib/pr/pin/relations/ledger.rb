module PR
  module Pin
    module Relations
      class Ledger < ROM::Relation[:pr_pin]
        schema(:ledger) do
          attribute :type, Types::Strict::String
          attribute :annotation, Types::Strict::String
          attribute :amount, Types::Strict::Integer
          attribute :currency, Types::Strict::String
          attribute :created_at, Types::JSON::DateTime
        end
      end
    end
  end
end
