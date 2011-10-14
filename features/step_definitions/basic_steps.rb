When /^I navigate to the (\w+) page$/ do |resource|
  visit "/#{resource}"
end

When /^I navigate to the (\w+) (\w+) page$/ do |resource, action|
  visit "/#{resource}/#{action}"
end