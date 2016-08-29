module SuperHttpCache
  def request(req, body = nil, &block)  # :yield: +response+
    if Rails.cache.read(:supercache)
      Rails.cache.fetch(req.path.to_s.hash) do
        super(req, body, &block)
      end
    else
      super(req, body, &block)
    end
  end
end

Net::HTTPRequest.prepend(SuperHttpCache)