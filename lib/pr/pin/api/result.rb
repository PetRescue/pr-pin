module PR
  module Pin
    module API
      class Result < SimpleDelegator
        attr_reader :__relation__
        private :__relation__

        def self.wrap(relation, &block)
          new(block.call, relation)
        rescue PR::Pin::Adapter::ResponseError => error
          relation.dataset.error_handler.(Error.new(error))
        end

        def initialize(result, relation)
          @__relation__ = relation
          super(result)
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
