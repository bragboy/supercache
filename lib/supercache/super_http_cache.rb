require 'net/http'
module SuperHttpCache
  def request(*args, &block)
    if Rails.cache.read(:http_supercache)
      Rails.cache.fetch(Digest::SHA1.hexdigest(args[0].path.to_s + args[0].body.to_s)) do
        super(*args, &block)
      end
    else
      super(*args, &block)
    end
  end
end
::Net::HTTP.prepend(SuperHttpCache)