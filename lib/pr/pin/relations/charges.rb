module PR
  module Pin
    module Relations
      class Charges < ROM::Relation[:pr_pin]
        schema(:charges) do
          attribute :token, PR::Pin::Types::Strict::String
          attribute :success, Types::Strict::Bool
          attribute :amount, Types::Strict::Integer
          attribute :currency, Types::Strict::String
          attribute :description, Types::Strict::String
          attribute :email, Types::Strict::String
          attribute :ip_address, Types::Strict::String
          attribute :created_at, Types::JSON::DateTime
          attribute :status_message, Types::Strict::String
          attribute :error_message, Types::Strict::String.optional
          attribute :card, Types::JSON::Hash
          attribute :transfer, Types::Array.of(Types::JSON::Hash)
          attribute :amount_refunded, Types::Strict::Integer
          attribute :total_fees, Types::Strict::Integer.optional
          attribute :merchant_entitlement, Types::Strict::Integer.optional
          attribute :refund_pending, Types::Strict::Bool
          attribute :authorisation_expired, Types::Strict::Bool
          attribute :captured, Types::Strict::Bool
          attribute :captured_at, Types::JSON::DateTime
          attribute :settlement_currency, Types::Strict::String
          attribute :metadata, Types::JSON::Hash
        end

        def for_customer(customer_token)
          with_base_path("/customers/#{customer_token}/charges")
        end
      end
    end
  end
end
