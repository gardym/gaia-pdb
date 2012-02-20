require 'spec_helper'

describe Parameter do
  before :all do
    @total_parameters = 36
    @max_results_per_page = 20
    @total_parameters.times do |index|
      Parameter.create(description: "description #{index}", unit: "unit #{index}", source: "source #{index}", expression: "expression #{index}")
    end
  end
        
  describe "Using an empty search filter with a page size greater than the number of paramaters"
    it "should return all of the parameters", :integration => true do
      results = Parameter.search 1, 50
      results.size.should == @total_parameters
    end
    
  describe "Using a valid search filter"
    it "should return results filtered by one criteria", :integration=>true do
      results  = Parameter.search 1, 20, SearchFilter.initialize_from({"unit" => "4"})
      results.size.should == 4
    end
    
    it "should return results filtered by two criteria", :integration=>true do
      results  = Parameter.search 1, 20, SearchFilter.initialize_from({"unit" => "1", "description" => "5"})
      results.size.should == 1
    end
    
  describe "Using pagination"
    it "should return the max number of results in a page", :integration=>true do
      results = Parameter.search 2, 20
      results.size.should == @max_results_per_page
    end

    it "should return results filtered in a page", :integration=>true do
      results = Parameter.search 1, 20, SearchFilter.initialize_from({"unit" => "1"})
      results.size.should == 13
    end
end