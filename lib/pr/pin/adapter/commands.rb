module PR
  module Pin
    module Adapter
      module Commands
        class Create < ROM::HTTP::Commands::Create
          adapter :pr_pin

          def execute(*args, &block)
            relation.new(super.map(&:to_h)).to_a
          end
        end

        class Update < ROM::HTTP::Commands::Update
          adapter :pr_pin

          def execute(*args, &block)
            relation.new(super.map(&:to_h)).to_a
          end
        end

        class Delete < ROM::HTTP::Commands::Delete
          adapter :pr_pin
        end
      end
    end
  end
end
