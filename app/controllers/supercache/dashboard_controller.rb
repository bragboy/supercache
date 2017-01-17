module Supercache
  class DashboardController < ActionController::Base
    layout 'supercache/application'

    before_filter :load_cache, only: :flip
    before_filter :load_query, only: :except_list

    def index
      @ar_cache = cache.read(:ar_supercache)
      @http_cache = cache.read(:http_supercache)
    end

    def except_list.
      queries = cache.read(:except) || []
      unless queries.try(:include?, @query)
        queries.push @query 
      end
      cache.write(:except, queries)
      redirect_to :root
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

    def load_query
      @query = params[:query]
    end

  end
end
