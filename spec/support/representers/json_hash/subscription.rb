module Representers
  module JSONHash
    class Subscription
      def call(subscription)
        {
          state: subscription.state,
          next_billing_date: subscription.next_billing_date,
          active_interval_started_at: subscription.active_interval_started_at,
          active_interval_finishes_at: subscription.active_interval_finishes_at,
          cancelled_at: subscription.cancelled_at,
          created_at: subscription.created_at,
          token: subscription.token,
          plan_token: subscription.plan_token,
          customer_token: subscription.customer_token,
          card_token: subscription.card_token
        }
      end
    end
  end
end
