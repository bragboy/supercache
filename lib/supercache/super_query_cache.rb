if RUBY_VERSION < "2.0"
  module ActiveRecord
    module ConnectionAdapters # :nodoc:
      module QueryCache
        def cache_sql_with_superquerycache(*args, &block)
          if Rails.cache.read(:ar_supercache)
            Rails.cache.fetch(Digest::SHA1.hexdigest("supercache_#{args[0]}_#{args[1]}")) do
              request_without_superquerycache(*args, &block)
            end
          else
            request_without_superquerycache(*args, &block)
          end
        end

        alias_method :request_without_superquerycache, :cache_sql
        alias_method :cache_sql, :cache_sql_with_superquerycache

      end
    end
  end
else
  module SuperQueryCache
    def cache_sql(*args, &block)
      if Rails.cache.read(:ar_supercache) && not_except_query?(args)
        Rails.cache.fetch(Digest::SHA1.hexdigest("supercache_#{args[0]}_#{args[1]}")) do
          super(*args, &block)
        end
      else
        super(*args, &block)
      end
    end
  end

  ActiveRecord::ConnectionAdapters::AbstractAdapter.prepend(SuperQueryCache)
end

def not_except_query?(args)
  return true if Rails.cache.read(:except).blank?
  Rails.cache.read(:except).select{|query| args[0] == query}.blank?
end
