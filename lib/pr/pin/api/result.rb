module PR
  module Pin
    module API
      class Result < SimpleDelegator
        def self.wrap(relation, &block)
          new(block.call)
        rescue PR::Pin::Adapter::Error => error
          relation.dataset.error_handler.(Error.new(error))
        end

        def success?
          true
        end

        def error?
          false
        end

        def inspect
          "#<#{self.class} - #{__getobj__}>"
        end
      end
    end
  end
end
