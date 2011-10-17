class ParametersController < ApplicationController
  
  def index
    retrieve_parameters
  end
  
  def search
    unless request.query_string.empty?
      retrieve_parameters SearchFilter.initialize_from(params)
      render :index 
    end    
  end

  private
  
  def retrieve_parameters(filter = SearchFilter.new)
    if filter.empty?
      @parameters = Parameter.all
    else
      query, params = filter.build_query
      @parameters = Parameter.where(query, *params)
    end    
  end
  
end
