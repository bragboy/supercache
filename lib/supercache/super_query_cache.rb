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

ActiveRecord::ConnectionAdapters::AbstractAdapter.prepend(SuperQueryCache)