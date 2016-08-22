module Supercache
  class DashboardController < ActionController::Base
    def flip
      if cache.read(:supercache) 
        cache.clear(:supercache)
      else
        cache.write(:supercache, true)
      end
      redirect_to :root
    end

    private

    def cache
      Rails.cache
    end
  end
end