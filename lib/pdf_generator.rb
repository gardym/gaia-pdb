require 'prawn'

class PdfGenerator
	def create_pdf(parameters)
		pdf = Prawn::Document.new

		pdf.table(collect_data_into_array(parameters), :header => true)

		pdf.render
	end

	def collect_data_into_array(parameters)
		data = [["Unit", "Source", "Expression", "Description"]]

		parameters.each do |p|
			data += [[p.unit, p.source, p.expression, p.description]]
		end

		data
	end
end