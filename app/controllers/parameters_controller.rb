require 'pdf_generator'

class ParametersController < ApplicationController
  
  before_filter :set_page_sizing_path
  
  def index
    @parameters = Parameter.search params[:page], params[:page_size]

    respond_to do |format|
      format.html { render :index }
      format.xml { render :xml => @parameters }
      format.pdf { render :text => PdfGenerator.new.create_pdf(@parameters) }
    end
  end
  
  def search
    unless request.query_string.empty?
      @parameters = Parameter.search params[:page], params[:page_size], SearchFilter.initialize_from(params)

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
    @page_sizing_path = url_for(:only_path => false) + "?" + remove_paging_information(request.query_string)
  end
  
  def remove_paging_information(query_string)
    query_string.gsub(/\&*page_size=[\d]*/, "").gsub(/\&*page=[\d]*/, "")
  end
  
end