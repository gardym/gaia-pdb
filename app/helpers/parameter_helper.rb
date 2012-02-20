module ParameterHelper  
  class SearchFilter
    @@criteria_field_map = {
      "unit" => "unit", 
      "source" => "source", 
      "description" => "description"
    }

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
end
