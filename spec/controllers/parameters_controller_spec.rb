require 'spec_helper'

describe ParametersController do
  describe "GET index"
    it "should return all parameters" do
      Parameter.stub(:all) {:some_params}
      
      get :index
      
      assigns(:parameters).should == :some_params
    end
    
    describe "GET search"
      it "should render the search form page when no query string" do        
        get :search
        
        response.should render_template("search")
        SearchFilter.should_not_receive(:new)
      end
      
      it "should return all parameters when search criteria are empty" do
        SearchFilter.any_instance.stub(:empty?) {true}
        Parameter.stub(:all) {:some_params}
        
        get :search, {:source => "", :unit => "", :description => ""}
        
        assigns(:parameters).should == :some_params
        response.should render_template("index")
      end
      
      it "should return parameters satisfying valid search criteria" do
        mock_filter = double('SearchFilter')
        SearchFilter.stub(:initialize_from).and_return(mock_filter)
        mock_filter.stub(:empty?) {false}
        mock_filter.stub(:build_query).and_return(["test.query", [1,2]])
        
        Parameter.stub(:where).with("test.query", 1, 2).and_return(:some_params)
        
        get :search, {:unit => "test.unit", :description => "test.description"}
        
        assigns(:parameters).should == :some_params
        response.should render_template("index")        
      end
end
