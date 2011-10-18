class ParametersController < ApplicationController
  
  def index
    @parameters = Parameter.search params[:page]
  end
  
  def search
    unless request.query_string.empty?
      @parameters = Parameter.search params[:page], SearchFilter.initialize_from(params)
      render :index 
    end    
  end
    
end
