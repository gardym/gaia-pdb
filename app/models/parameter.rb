class Parameter < ActiveRecord::Base
  
  def self.search(page_number, options = {})
    page_number = page_number ||= 1
    filter = options[:filter] ||= SearchFilter.new
    page_size = options[:page_size] ||= 20
    
    if filter.empty?
      paginate(:page => page_number, :per_page => page_size)
    else
      query, params = filter.build_query
      where(query, *params).paginate(:page => page_number, :per_page => page_size)
    end  
  end
  
end
