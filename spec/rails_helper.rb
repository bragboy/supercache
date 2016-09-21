# Configure Rails Envinronment
ENV['RAILS_ENV'] = 'test'
CI_ORM = (ENV['CI_ORM'] || :active_record).to_sym
CI_TARGET_ORMS = [:active_record].freeze

require File.expand_path('../dummy_app/config/environment', __FILE__)

require 'rspec/rails'
require 'database_cleaner'

Dir[File.expand_path('../support/**/*.rb', __FILE__)].each { |f| require f }

Rails.backtrace_cleaner.remove_silencers!

RSpec.configure do |config|

  config.use_transactional_fixtures = true

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include RSpec::Matchers

  config.before do |example|
    DatabaseCleaner.strategy = (CI_ORM == :mongoid || example.metadata[:js]) ? :truncation : :transaction

    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  CI_TARGET_ORMS.each do |orm|
    if orm == CI_ORM
      config.filter_run_excluding "skip_#{orm}".to_sym => true
    else
      config.filter_run_excluding orm => true
    end
  end
end