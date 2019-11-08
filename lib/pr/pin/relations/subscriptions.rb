module PR
  module Pin
    module Relations
      class Subscriptions < ROM::Relation[:pr_pin]
        schema(:subscriptions) do
          attribute :state, Types::Strict::String
          attribute :next_billing_date, Types::JSON::DateTime
          attribute :active_interval_started_at, Types::JSON::DateTime
          attribute :active_interval_finishes_at, Types::JSON::DateTime.optional
          attribute :cancelled_at, Types::JSON::DateTime.optional
          attribute :created_at, Types::JSON::DateTime
          attribute :token, Types::Strict::String
          attribute :plan_token, Types::Strict::String
          attribute :customer_token, Types::Strict::String.optional
          attribute :card_token, Types::Strict::String.optional
        end
      end
    end
  end
end
