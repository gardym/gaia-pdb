Given /^there are (\d+) parameters$/ do |number|
  number.to_i.times do |index|
    Parameter.create(description: "description #{index}", unit: "unit #{index}", source: "source #{index}", expression: "expression #{index}")
  end
end

Then /^I should see (\d+) parameters$/ do |number|
  page.all(".parameter").count.should == number.to_i
end


