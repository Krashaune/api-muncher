require 'vcr'
require 'webmock/minitest'

ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/rails"
require "minitest/reporters"  # for Colorized output

#  For colorful output!
Minitest::Reporters.use!(
Minitest::Reporters::SpecReporter.new,
ENV,
Minitest.backtrace_filter
)

if ActionPack::VERSION::STRING >= "5.2.0"
  Minitest::Rails::TestUnit = Rails::TestUnit
end


# To add Capybara feature tests add `gem "minitest-rails-capybara"`
# to the test group in the Gemfile and uncomment the following:
# require "minitest/rails/capybara"

# Uncomment for awesome colorful output
# require "minitest/pride"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  # Add more helper methods to be used by all tests here...

  VCR.configure do |config|
    config.cassette_library_dir = 'test/cassettes'
    config.hook_into :webmock
    config.default_cassette_options = {
      :record => :new_episodes,
      :match_requests_on => [:method, :uri, :body]
    }

    config.filter_sensitive_data("<EDAMAM_TOKEN>") do
      ENV['APP_ID']
    end
  end

  VCR.configure do |config|
    config.cassette_library_dir = 'test/cassettes'
    config.hook_into :webmock
    config.default_cassette_options = {
      :record => :new_episodes,
      :match_requests_on => [:method, :uri, :body]
    }

    config.filter_sensitive_data("<EDAMAM_TOKEN>") do
      ENV['APP_KEY']
    end
  end
end
