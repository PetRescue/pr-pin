module Representers
  module JSONHash
    class Refund
      def call(refund)
        {
          token: refund.token,
          success: refund.success,
          amount: refund.amount,
          currency: refund.currency,
          charge: refund.charge,
          error_message: refund.error_message,
          status_message: refund.status_message,
          created_at: refund.created_at
        }
      end
    end
  end
end
