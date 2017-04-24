module Supercache
  class DashboardController < ActionController::Base
    protect_from_forgery
    layout 'supercache/application'

    before_filter :load_cache, only: :flip

    def index
      @ar_cache = cache.read(:ar_supercache)
      @http_cache = cache.read(:http_supercache)
    end

    def flip
      if cache.read(@cache)
        cache.delete(@cache)
      else
        cache.write(@cache, true)
      end
      redirect_to :root
    end

    private

    def cache
      Rails.cache
    end

    def load_cache
      @cache = params[:cache]
    end
  end
end