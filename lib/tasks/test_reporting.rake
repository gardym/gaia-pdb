namespace :doc do

  desc "run features and specs then generate test reports in html"
  task :test_reports do
    # Delete old files
    puts "Clearing out old html files..."
    system("rm -rf reports/")
    system("mkdir reports/")

    # Generate the feature html files
    puts "Running Cucumber tests..."
    system("bundle exec cucumber --format html -o reports/cucumber_tests.html")

    # Generate RSpec html files
    puts "Running RSpec tests..."
    system("bundle exec rspec --format html -o reports/rspec_tests.html")

    puts "Done!"
  end
end
