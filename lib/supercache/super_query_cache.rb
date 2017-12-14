module SuperQueryCacheRails51AndAbove
  #Because of https://github.com/rails/rails/commit/84d35da86c14767c737783cb95dd4624632cc1bd
  def cache_sql(*args, name, &block)
    if Rails.cache.read(:ar_supercache)
      sub_key = name.collect{|a| "#{a.try(:name)} #{a.try(:value)}"}
      Rails.cache.fetch(Digest::SHA1.hexdigest("supercache_#{args[0]}_#{sub_key}")) do
        super(*args, name, &block)
      end
    else
      super(*args, name, &block)
    end
  end
end

module SuperQueryCache
  def cache_sql(*args, &block)
    if Rails.cache.read(:ar_supercache)
      sub_key = args[1].collect{|a| "#{a.try(:name)} #{a.try(:value)}"}
      Rails.cache.fetch(Digest::SHA1.hexdigest("supercache_#{args[0]}_#{sub_key}")) do
        super(*args, &block)
      end
    else
      super(*args, &block)
    end
  end
end

if (Rails::VERSION::MAJOR > 5) || (Rails::VERSION::MAJOR == 5 && Rails::VERSION::MINOR >= 1)
  ActiveRecord::ConnectionAdapters::AbstractAdapter.prepend(SuperQueryCacheRails51AndAbove)
else
  ActiveRecord::ConnectionAdapters::AbstractAdapter.prepend(SuperQueryCache)
end