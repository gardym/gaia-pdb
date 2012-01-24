require 'pdf_generator'

class ParametersController < ApplicationController
  
  def index
    @parameters = Parameter.search params[:page]

    respond_to do |format|
      format.html { render :index }
      format.xml { render :xml => @parameters }
      format.pdf { render :text => PdfGenerator.new.create_pdf(@parameters) }
    end
  end
  
  def search
    unless request.query_string.empty?
      @parameters = Parameter.search params[:page], SearchFilter.initialize_from(params)

      respond_to do |format|
        format.html { render :index }
        format.xml { render :xml => @parameters }
        format.pdf { render :text => PdfGenerator.new.create_pdf(@parameters) }
      end
    end
  end
end