class ParametersController < ApplicationController
  class SearchFilter
    @@criteria_field_map = {
      "unit" => "unit", 
      "source" => "source", 
      "description" => "description"
    }
    class_eval { @@criteria_field_map.each_key {|c| attr_reader c} }
    
    def self.initialize_from params
      valid_criteria = params.select do |k,v|
        @@criteria_field_map.has_key?k and !v.nil? and !v.empty?
      end
      sc = new
      sc.instance_variable_set(:@criteria, Hash[valid_criteria.map {|k,v| [@@criteria_field_map[k], v]}])
      return sc
    end
    
    def empty?
      @criteria.nil? or @criteria.empty?
    end
    
    def build_query
      where_condition = @criteria.keys.first + @criteria.keys.drop(1).inject(" LIKE ?") {|q, p| q + " AND #{p} LIKE ?"}
      return where_condition, @criteria.values.map{|v| "%#{v}%"}
    end
    
  end
  
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
