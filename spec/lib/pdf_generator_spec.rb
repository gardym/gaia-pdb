require "rspec"
require "pdf_generator"

describe "PdfGenerator" do
  generator = PdfGenerator.new

  it "returns a string representation of a pdf" do
    parameter = double("parameter", :unit => "a", :source => "b", :expression => "c", :description => "d")

    generator.create_pdf([parameter]).starts_with?("%PDF").should == true
  end

  it "returns data as array with a header" do
    parameter = double("parameter", :unit => "a", :source => "b", :expression => "c", :description => "d")

    generator.collect_data_into_array([parameter]).should == [["Unit", "Source", "Expression", "Description"], ["a", "b", "c", "d"]]
  end

  it "returns data for all the parameters provided" do
    parameter = double("parameter", :unit => "a", :source => "b", :expression => "c", :description => "d")
    parameter2 = double("parameter2", :unit => "e", :source => "f", :expression => "g", :description => "h")

    generator.collect_data_into_array([parameter, parameter2]).should == [["Unit", "Source", "Expression", "Description"], ["a", "b", "c", "d"], ["e", "f", "g", "h"]]
  end

  it "returns just the header when no parameters provided" do
    generator.collect_data_into_array([]).should == [["Unit", "Source", "Expression", "Description"]]
  end
end