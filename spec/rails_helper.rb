# Configure Rails Envinronment
ENV['RAILS_ENV'] = 'test'

require File.expand_path('../test_app/config/environment', __FILE__)

require 'rspec/rails'
require 'fileutils'

FileUtils.mkdir_p './spec/test_app/tmp/cache'

RSpec.configure do |config|

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include RSpec::Matchers

end