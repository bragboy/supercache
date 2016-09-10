module Net
  class HTTP
    def request_with_superhttpcache(*args, &block)
      if Rails.cache.read(:http_supercache)
        Rails.cache.fetch(args[0].path.to_s.hash) do
          request_without_superhttpcache(*args, &block)
        end
      else
        request_without_superhttpcache(*args, &block)
      end
    end

    alias_method :request_without_superhttpcache, :request
    alias_method :request, :request_with_superhttpcache

  end
end