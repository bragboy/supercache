require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module TestApp
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true if Rails::VERSION::MAJOR == 4 && Rails::VERSION::MINOR == 2
  end
end
