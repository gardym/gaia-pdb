Given /^there are (\d+) parameters$/ do |number|
  number.to_i.times do |index|
    Parameter.create(description: "description #{index}", unit: "unit #{index}", source: "source #{index}", expression: "expression #{index}")
  end
end

Then /^I should see (\d+) parameters$/ do |number|
  page.all(".parameter").count.should == number.to_i
end

Then /^I should see the first (\d+) parameters out of a total of (\d+)$/ do |page_size, total|
  page.all(".parameter").count.should == page_size.to_i
  within(".page_info") do
    page.text.should match(Regexp.new "1.*-.*#{page_size}.*of.*#{total}")
  end
end

Then /^the export as xml button exists$/ do
  page.find_by_id("export_xml")
end

Then /^the export as pdf button exists$/ do
  page.find_by_id("export_pdf")
end

When /^I export the results as pdf$/ do
  page.find_by_id("export_pdf").click
end

When /^I export the results as xml$/ do
  page.find_by_id("export_xml").click
end

When /^I choose to view the next page$/ do
  page.find("a.next_page").click
end

Then /^the current page should be (\d+)$/ do |page_number|
    page.find(".pagination em.current").text.should == "#{page_number}"
end

Then /^I should get a response with content-type "([^"]*)"$/ do |content_type|
  page.response_headers['Content-Type'].should include content_type
end