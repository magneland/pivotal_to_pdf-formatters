require 'simplecov'
SimpleCov.start do
  SimpleCov.at_exit do
    threshold = 100
    SimpleCov.result.format!
    if SimpleCov.result.covered_percent != threshold
      actual_coverage = SimpleCov.result.covered_percent
      puts "The coverage is #{actual_coverage}%. It has to be 100%"
      exit 1
    end
  end
end
require 'spork'
require 'guard/spork'

Spork.prefork do
  require 'rspec/core'
  Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
  require "#{File.dirname(__FILE__)}/../lib/pivotal_to_pdf-formatters"

  RSpec.configure do |config|
    config.mock_with :rspec
  end
end

Spork.each_run do
  load "#{File.dirname(__FILE__)}/../lib/pivotal_to_pdf-formatters.rb"
  Dir["#{File.dirname(__FILE__)}/../lib/pivotal_to_pdf-formatters/*.rb"].each {|f| load f}
end

