module Supercache
  class DashboardController < ActionController::Base
    protect_from_forgery
    layout 'supercache/application'

    before_filter :load_cache, only: :flip

    def index
      @ar_cache = cache.read(:ar_supercache)
      @http_cache = cache.read(:http_supercache)
      @sql_exp = cache.read(:sql_exp)
      @http_exp = cache.read(:http_exp)
    end

    def flip
      if cache.read(@cache)
        cache.delete(:sql_exp) if @cache == "ar_supercache"
        cache.delete(:http_exp) if @cache == "http_supercache"
        cache.delete(@cache)
      else
        cache.write(@cache, true)
      end
      redirect_to :root
    end

    def add_to_sql_exception
      sql_exp = cache.read(:sql_exp)
      sql_exp[params[:sql]] = params[:status] == "false"
      cache.write(:sql_exp,sql_exp)
      redirect_to :root
    end

    def add_to_http_exception
      http_exp = cache.read(:http_exp)
      http_exp[params[:url]] = params[:status] == "false"
      cache.write(:http_exp,http_exp)
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