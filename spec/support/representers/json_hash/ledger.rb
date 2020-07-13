module Representers
  module JSONHash
    class Ledger
      def call(ledger)
        {
          type: ledger.type,
          annotation: ledger.annotation,
          amount: ledger.amount,
          currency: ledger.currency,
          created_at: ledger.created_at
        }
      end
    end
  end
end
