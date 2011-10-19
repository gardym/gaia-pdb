require 'rubygems'
require 'ci/reporter/rake/rspec'
require 'cucumber/rake/task'
require 'fileutils'

namespace :cucumber do
  Cucumber::Rake::Task.new("junit_report", "Run cucumber features and create a junit report") do |t|
    t.cucumber_opts = %w{--format junit --out 'features/reports'}
  end

  Cucumber::Rake::Task.new("html_report", "Run cucumber features and create a HTML report") do |t|
    t.cucumber_opts = %w{--format html --out 'features/reports/features.html'}
  end

  desc "Cleanup test report folders"
  task :clean_reports do |t|
    FileUtils.rm_rf 'features/reports'
    FileUtils.mkdir_p 'features/reports'
  end
  
  task :junit_report => [:clean_reports]
  task :html_report => [:clean_reports]

end

namespace :spec do
  desc "Run RSpec and create a html report"
  RSpec::Core::RakeTask.new('html_report') do |t|
    # t.desc('Run RSpec and create a html report')
    t.rspec_opts = %w{--format html --out 'spec/reports/rspec.html'}
  end
  
  task :html_report =>[:clean_reports]
  
  desc "Run RSpec and create a junit report"
  task :junit_report =>['ci:setup:rspec', :spec]
end



