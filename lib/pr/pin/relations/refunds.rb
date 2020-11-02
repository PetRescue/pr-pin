module PR
  module Pin
    module Relations
      class Refunds < ROM::Relation[:pr_pin]
        schema(:refunds) do
          attribute :token, Types::Strict::String
          attribute :success, Types::Bool.optional
          attribute :amount, Types::Strict::Integer
          attribute :currency, Types::Strict::String
          attribute :charge, Types::Strict::String
          attribute :error_message, Types::Strict::String.optional
          attribute :status_message, Types::Strict::String
          attribute :created_at, Types::JSON::DateTime
        end

        def for_charge(charge_token)
          with_base_path("/charges/#{charge_token}/refunds")
        end
      end
    end
  end
end
