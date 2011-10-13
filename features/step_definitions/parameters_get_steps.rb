Given /^there are (\d+) parameters$/ do |number|
  number.to_i.times do |index|
    Parameter.create(description: "description #{index}", unit: "unit #{index}", source: "source #{index}", expression: "expression #{index}")
  end
end

When /^I navigate to the parameters page$/ do
  visit parameters_path
end

Then /^I should see (\d+) parameters$/ do |arg1|
  page.all(".parameter").count.should == 5
end


