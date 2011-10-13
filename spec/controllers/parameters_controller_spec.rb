require 'spec_helper'

describe ParametersController do
  describe "GET index"
    it "should return all parameters" do
      Parameter.stub!(:all) {:some_params}
      
      get :index
      
      assigns(:parameters).should == :some_params
    end
end