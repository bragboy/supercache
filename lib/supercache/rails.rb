require 'supercache/silverware'
require 'pry'

module Supercache
  class Railtie < Rails::Railtie
    initializer "supercache.configure_rails_initialization" do
      if use_supercache?
        insert_middleware
      end
    end

    def insert_middleware
      app.middleware.use Silverware
    end

    def use_supercache?
      !Rails.env.production? and app.config.consider_all_requests_local
    end

    def app
      Rails.application
    end
  end
end