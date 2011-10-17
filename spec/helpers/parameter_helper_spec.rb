require 'spec_helper'

describe ParameterHelper do
  describe SearchFilter do
    describe "initialize as empty"
      it "should be empty if created with no parameters" do
        SearchFilter.new.empty?.should be true
      end

      it "should be empty when no parameters match the search criteria" do
        SearchFilter.initialize_from({"some_param"=>"123"}).empty?.should be true
      end
    
    describe "initialize from valid parameters"
      it "should not be empty when at least one parameter matches one of the search criteria" do
        sc = SearchFilter.initialize_from({"some_param"=>"123", "unit"=>"test.unit"}).empty?.should be false
      end
  
      it "should build a query from one search criteria" do
        sc = SearchFilter.initialize_from({"unit"=>"test.unit"})
      
        where, params = sc.build_query
        where.should be == "unit LIKE ?"
        params.should == ["%test.unit%"]
      
      end
      
      it "should build a query from multiple search criteria" do
        sc = SearchFilter.initialize_from({"unit"=>"test.unit", "description"=>"test.description"})
      
        where, params = sc.build_query
        where.should be == "unit LIKE ? AND description LIKE ?"
        params.should == ["%test.unit%", "%test.description%"]
      
      end
  end
end