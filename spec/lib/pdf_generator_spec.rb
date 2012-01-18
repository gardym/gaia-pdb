require "rspec"
require "pdf_generator"

describe "PdfGenerator" do
	it "returns a string representation of a pdf" do
		parameter = double("parameter", :unit => "a", :source => "b", :expression => "c", :description => "d")

		generator = PdfGenerator.new

		generator.create_pdf([parameter]).starts_with?("%PDF").should == true
	end

	it "returns data as array with a header" do
		parameter = double("parameter", :unit => "a", :source => "b", :expression => "c", :description => "d")

		generator = PdfGenerator.new

		generator.collect_data_into_array([parameter]).should == [["Unit", "Source", "Expression", "Description"], ["a", "b", "c", "d"]]
	end
end