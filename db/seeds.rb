# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'

CSV.open('db/csv/PARAM_REAL.csv').each_with_index do |row, index|
  unless index == 0 
    Parameter.create(description: row[17], unit: row[16], source: row[18], expression: row[19])
  end
end