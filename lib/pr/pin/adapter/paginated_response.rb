module PR
  module Pin
    module Adapter
      class PaginatedResponse < SimpleDelegator
        attr_reader :pagination_params

        def initialize(dataset, pagination_params = {})
          super(dataset)
          @pagination_params = pagination_params
        end

        def paginates?
          true
        end

        def current_page
          pagination_params[:current]
        end

        def per_page
          pagination_params[:per_page]
        end

        def next_page
          current_page.next if current_page && current_page < total_pages
        end

        def prev_page
          current_page.pred if current_page && current_page > 1
        end

        def total_pages
          (total_count / per_page.to_f).ceil if total_count && per_page
        end

        def total_count
          pagination_params[:count]
        end

        def class
          __getobj__.class
        end
      end
    end
  end
end
