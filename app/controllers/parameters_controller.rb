require "prawn"

class ParametersController < ApplicationController
  
  def index
    @parameters = Parameter.search params[:page]
  end
  
  def search
    unless request.query_string.empty?
      @parameters = Parameter.search params[:page], SearchFilter.initialize_from(params)

      respond_to do |format|
        format.html { render :index }
        format.xml { render :xml => @parameters }
        format.pdf { render :text => create_pdf(@parameters) }
      end
    end
  end

  private

  def create_pdf(parameters)
    pdf = Prawn::Document.new

    data = [["Unit", "Source", "Expression", "Description"]]

    parameters.each do |p|
      data += [[p.unit, p.source, p.expression, p.description]]
    end

    pdf.table(data, :header => true)

    pdf.render
  end

end