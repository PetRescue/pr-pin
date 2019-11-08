module PR
  module Pin
    module Relations
      class Plans < ROM::Relation[:pr_pin]
        schema(:plans) do
          attribute :name, Types::Strict::String
          attribute :amount, Types::Strict::Integer
          attribute :currency, Types::Strict::String
          attribute :setup_amount, Types::Strict::Integer
          attribute :trial_amount, Types::Strict::Integer
          attribute :interval, Types::Strict::Integer
          attribute :interval_unit, Types::Strict::String
          attribute :intervals, Types::Strict::Integer
          attribute :trial_interval, Types::Strict::Integer
          attribute :trial_interval_unit, Types::Strict::String
          attribute :created_at, Types::JSON::DateTime
          attribute :token, Types::Strict::String
          attribute :customer_permissions, Types::JSON::Array.of(
            Types::Strict::String
          )
          attribute :subscription_counts, Types::JSON::Hash
        end
      end
    end
  end
end
