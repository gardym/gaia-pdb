Then /^I should see a search form with the following input criteria:$/ do |search_criteria|
  page.should have_button('Search')
  search_criteria.rows.each do |criteria|
    field_name = criteria[0]
    page.should have_field(field_name)
  end
end
