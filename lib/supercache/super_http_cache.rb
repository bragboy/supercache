require 'net/http'
module SuperHttpCache
  def request(*args, &block)
    if Rails.cache.read(:http_supercache)
      http_exp = Rails.cache.fetch(:http_exp) { {} }
      url = args[0].path.to_s + args[0].body.to_s
      unless http_exp.has_key?(url)
        http_exp[url] = false
        Rails.cache.write(:http_exp,http_exp)
      end
      if http_exp.select { |k,v| v == true }.include?(url)
        super(*args, &block)
      else
        Rails.cache.fetch(Digest::SHA1.hexdigest(url)) do
          super(*args, &block)
        end
      end
    else
      super(*args, &block)
    end
  end
end
::Net::HTTP.prepend(SuperHttpCache)