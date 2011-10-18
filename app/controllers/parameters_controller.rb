class ParametersController < ApplicationController
  
  def index
    retrieve_parameters params[:page]
  end
  
  def search
    unless request.query_string.empty?
      retrieve_parameters SearchFilter.initialize_from(params), params[:page]
      render :index 
    end    
  end

  private
  
  def retrieve_parameters(filter = SearchFilter.new, page)
    if filter.empty?
      @parameters = Parameter.page(page)
    else
      query, params = filter.build_query
      @parameters = Parameter.where(query, *params).paginate(:page => page)
    end    
  end
  
end
