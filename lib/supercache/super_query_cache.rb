module SuperQueryCache
  def cache_sql(sql, binds)
    if Rails.cache.read(:ar_supercache)
      Rails.cache.fetch(Digest::SHA1.hexdigest("supercache_#{sql}_#{binds.to_s}")) do
        super(sql, binds)
      end
    else
      super(sql, binds)
    end
  end
end

ActiveRecord::ConnectionAdapters::AbstractAdapter.prepend(SuperQueryCache)