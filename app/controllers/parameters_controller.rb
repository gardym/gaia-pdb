class ParametersController < ApplicationController
  def index
    @parameters = Parameter.all
  end
end
