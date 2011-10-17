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
      end
      
      it "should return all parameters when search criteria are empty" do
        Parameter.stub(:all) {:some_params}
        
        get :search, {:source => "", :unit => "", :description => ""}
        
        assigns(:parameters).should == :some_params
        response.should render_template("index")
      end
      
      it "should return parameters satisfying one search criteria" do
        Parameter.stub(:where).with("description LIKE ?", "%test.description%").and_return(:some_params)
        
        get :search, {:description => "test.description"}
        
        assigns(:parameters).should == :some_params
        response.should render_template("index")        
      end

      it "should return parameters satisfying multiple search criteria" do
        Parameter.stub(:where).with("unit LIKE ? AND description LIKE ?", "%test.unit%", "%test.description%").and_return(:some_params)
        
        get :search, {:unit => "test.unit", :description => "test.description"}
        
        assigns(:parameters).should == :some_params
        response.should render_template("index")        
      end
end