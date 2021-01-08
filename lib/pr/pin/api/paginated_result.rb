module PR
  module Pin
    module API
      class PaginatedResult < Result
        def each_page(&_block)
          return enum_for(:each_page) unless block_given?

          page = self

          loop do
            yield(page)

            break unless page.next_page

            relation = __relation__.add_query_params(page: page.next_page)
            page = self.class.wrap(relation) { relation.paginate }
          end
        end

        def pages
          page = self

          return [page] unless page.next_page

          to_fetch = page.next_page..page.total_pages

          remaining_pages = to_fetch.map do |page_num|
            Concurrent::Promises.future do
              relation = __relation__.add_query_params(page: page_num)
              self.class.wrap(relation) { relation.paginate }
            end
          end

          [page, *remaining_pages.map(&:value!)]
        end
      end
    end
  end
end
