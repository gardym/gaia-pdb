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
		generator = PdfGenerator.new
		generator.create_pdf(parameters)
	end
end