class Parameter < ActiveRecord::Base
  
  def self.search(page_number, page_size, filter = SearchFilter.new)
    
    if filter.empty?
      paginate(:page => page_number, :per_page => page_size)
    else
      query, params = filter.build_query
      where(query, *params).paginate(:page => page_number, :per_page => page_size)
    end  
  end
  
end
