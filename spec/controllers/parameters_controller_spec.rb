require 'spec_helper'

describe ParametersController do
    
  describe "GET index" do
    it "should return all parameters" do
      Parameter.stub(:search).with("test.page", 20) {:some_params}

      get :index, {:page => "test.page"}

      assigns(:parameters).should == :some_params
    end
    
  end

  describe "GET search with pagination" do
    it "should render the search form page when no query string" do
      Parameter.stub(:search)
      get :search

      response.should render_template("search")
      SearchFilter.should_not_receive(:new)
    end

    it "should return all parameters when search criteria are empty" do
      SearchFilter.any_instance.stub(:empty?) {true}
      Parameter.stub(:search).with("test.page", "20", instance_of(SearchFilter)) {:some_params}

      get :search, {:source => "", :unit => "", :description => "", :page => "test.page", :page_size => 20}

      assigns(:parameters).should == :some_params
      response.should render_template("index")
    end

    it "should return parameters satisfying valid search criteria" do
      mock_filter = double('SearchFilter')
      SearchFilter.stub(:initialize_from)
                  .with(hash_including({"unit" => "test.unit", "description" => "test.description"}))
                  .and_return(mock_filter)
      Parameter.stub(:search).with("test.page", 20, mock_filter) {:some_params}

      get :search, {:page => "test.page", :unit => "test.unit", :description => "test.description"}

      assigns(:parameters).should == :some_params
      response.should render_template("index")
    end
    
  end

  describe "xml export" do
    it "return xml data on search" do
      SearchFilter.any_instance.stub(:empty?) {true}
      Parameter.stub(:search).with("test.page", 20, instance_of(SearchFilter)) {:some_params}

      get :search, {:format => :xml, :source => "", :unit => "", :description => "", :page => "test.page"}

      response.header["Content-Type"].should include("application/xml")
    end

    it "return xml data on index" do
      get :index, {:format => :xml}

      response.header["Content-Type"].should include("application/xml")
    end
  end

  describe "pdf export" do
    it "return pdf data on search" do
      SearchFilter.any_instance.stub(:empty?) {true}

      parameter = double("parameter", :unit => "", :source => "", :expression => "", :description => "")
      Parameter.stub(:search).with("test.page", 20, instance_of(SearchFilter)) {[parameter]}

      get :search, {:format => :pdf, :source => "", :unit => "", :description => "", :page => "test.page"}

      response.header["Content-Type"].should include("application/pdf")
    end

    it "return pdf data on index" do
      get :index, {:format => :pdf}

      response.header["Content-Type"].should include("application/pdf")
    end
  end
end
