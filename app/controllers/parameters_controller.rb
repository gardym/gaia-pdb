require 'pdf_generator'

class ParametersController < ApplicationController
  
  helper_method :get_page_size, :get_page_sizing_path
  
  def index
    @parameters = Parameter.search params[:page], get_page_size 

    respond_to do |format|
      format.html { render :index }
      format.xml { render :xml => @parameters }
      format.pdf { render :text => PdfGenerator.new.create_pdf(@parameters) }
    end
  end
  
  def search
    unless request.query_string.empty?
      @parameters = Parameter.search params[:page], get_page_size, SearchFilter.initialize_from(params)

      respond_to do |format|
        format.html { render :index }
        format.xml { render :xml => @parameters }
        format.pdf { render :text => PdfGenerator.new.create_pdf(@parameters) }
      end
    end
  end
  
  private
  
  def get_page_size
    params[:page_size] ||= 20
  end
  
  def get_page_sizing_path
    url_for(:only_path => false) + "?" + 
      request.query_string.gsub(/\&*page_size=[\d]*/, "").gsub(/\&*page=[\d]*/, "")
  end
  
end