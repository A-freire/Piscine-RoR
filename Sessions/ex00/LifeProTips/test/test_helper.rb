ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module Rails
  module LineFiltering
    def run(*args)
      if args.size <= 2
        reporter = args.first
        options = args.second || {}
        options = options.dup
        options[:filter] = Rails::TestUnit::Runner.compose_filter(self, options[:filter])
        super(reporter, options)
      else
        super(*args)
      end
    end
  end
end

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
  def sign_in_as(user, login: user.email, password: "password123")
    post log_in_path, params: { login:, password: }
  end
end
