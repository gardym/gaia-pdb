class Parameter < ActiveRecord::Base
  self.per_page = 20
  
  def self.search(page_number, filter = SearchFilter.new)
    if filter.empty?
      page(page_number)
    else
      query, params = filter.build_query
      where(query, *params).paginate(:page => page_number)
    end  
  end
  
end
