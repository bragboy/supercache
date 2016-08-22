module SuperQueryCache
  def cache_sql(sql, binds)
    if Rails.cache.read(:supercache)
      Rails.cache.fetch("supercache_#{sql}_#{binds.to_s}".hash) do
        super(sql, binds)
      end
    else
      super(sql, binds)
    end
  end
end

ActiveRecord::ConnectionAdapters::AbstractAdapter.prepend(SuperQueryCache)