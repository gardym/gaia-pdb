require 'rubygems'
require 'ci/reporter/rake/rspec'
require 'cucumber/rake/task'

namespace :cucumber do    
  Cucumber::Rake::Task.new("junit_report", "Run cucumber features and create a junit report") do |t|
    t.cucumber_opts = %w{--format junit --out 'features/reports'}
  end

  Cucumber::Rake::Task.new("html_report", "Run cucumber features and create a HTML report") do |t|
    t.cucumber_opts = %w{--format html --out 'features/reports/features.html'}
  end

  desc "Cleanup test report folder"
  task :clean_reports do |t|
    rm_rf 'features/reports'
    mkdir_p 'features/reports'
  end
  
  task :junit_report => [:clean_reports, 'db:test:prepare']
  task :html_report => [:clean_reports, 'db:test:prepare']

end

namespace :spec do
  desc "Run all specs and create a HTML report"
  RSpec::Core::RakeTask.new('html_report') do |t|
    t.rspec_opts = %w{--format html --out 'spec/reports/rspec.html'}
  end
    
  desc "Run all specs and create a junit report"
  task :junit_report =>['ci:setup:rspec', :spec]
end



