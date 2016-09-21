# Configure Rails Envinronment
ENV['RAILS_ENV'] = 'test'
CI_ORM = (ENV['CI_ORM'] || :active_record).to_sym
CI_TARGET_ORMS = [:active_record].freeze

require File.expand_path('../dummy_app/config/environment', __FILE__)

require 'rspec/rails'
require 'database_cleaner'
require 'fileutils'


Rails.backtrace_cleaner.remove_silencers!

Dir[File.expand_path('../support/**/*.rb', __FILE__)].each { |f| require f }

FileUtils.mkdir_p './spec/dummy_app/tmp/cache'

$original_sunspot_session = Sunspot.session


RSpec.configure do |config|

  config.before do
    Sunspot.session = SunspotMatchers::SunspotSessionSpy.new(Sunspot.session)
  end

  config.before :each, solr: true do
    Sunspot::Rails::Tester.start_original_sunspot_session
    Sunspot.session = $original_sunspot_session
    Sunspot.remove_all!
  end

  # config.use_transactional_fixtures = true

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include RSpec::Matchers
  config.include SunspotMatchers

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