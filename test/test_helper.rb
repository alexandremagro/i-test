ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'support/const'
require 'support/helpers/authentication_helper'

class ActiveSupport::TestCase
  include AuthenticationHelper

  # Run tests in parallel with specified workers
  # NOTE: To increase number of process, need configure a database schema by each process
  parallelize(workers: 1)

  setup do
    Mongoid.truncate!
  end
end
