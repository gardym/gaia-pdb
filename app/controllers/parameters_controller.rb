require 'pdf_generator'

class ParametersController < ApplicationController
  
  before_filter :set_page_sizing_path
  
  def index
    @parameters = Parameter.search params[:page], :page_size => params[:page_size]

    respond_to do |format|
      format.html { render :index }
      format.xml { render :xml => @parameters }
      format.pdf { render :text => PdfGenerator.new.create_pdf(@parameters) }
    end
  end
  
  def search
    unless request.query_string.empty?
      @parameters = Parameter.search params[:page], :filter => SearchFilter.initialize_from(params), :page_size => params[:page_size]

      respond_to do |format|
        format.html { render :index }
        format.xml { render :xml => @parameters }
        format.pdf { render :text => PdfGenerator.new.create_pdf(@parameters) }
      end
    end
  end
  
  private
  
  def set_page_sizing_path
    @page_size = (params[:page_size] ||= 20)
    base_query_string = request.query_string.gsub(/\&*page_size=[\d]*/, "").gsub(/\&*page=[\d]*/, "")
    @page_sizing_path = url_for(:only_path => false) + "?" + base_query_string
  end
  
end