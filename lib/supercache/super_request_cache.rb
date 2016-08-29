module Net
  class HTTP < Protocol
    def supercache_request(req, body = nil, &block)  # :yield: +response+
      if Rails.cache.read(:http_supercache)
        Rails.cache.fetch(req.path.to_s.hash) do
	  request_without_supercache(req, body, &block)
        end
      else
        request_without_supercache(req, body, &block)
      end
    end

    alias_method :request_without_supercache, :request
    alias_method :request, :supercache_request

  end
end
