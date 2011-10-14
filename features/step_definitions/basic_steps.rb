When /^I navigate to the (\w+) page$/ do |page_name|
  visit "/#{page_name}"
end