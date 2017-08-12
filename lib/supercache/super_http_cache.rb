require 'net/http'
module Net
  class HTTP
    def request_with_superhttpcache(*args, &block)
      if Rails.cache.read(:http_supercache)
        http_exp = Rails.cache.fetch(:http_exp) { {} }
        url = args[0].path.to_s + args[0].body.to_s
        unless http_exp.has_key?(url)
          http_exp[url] = false
          Rails.cache.write(:http_exp,http_exp)
        end
        if http_exp.select { |k,v| v == true }.include?(url)
          request_without_superhttpcache(*args, &block)
        else
          Rails.cache.fetch(Digest::SHA1.hexdigest(url)) do
            request_without_superhttpcache(*args, &block)
          end
        end
      else
        request_without_superhttpcache(*args, &block)
      end
    end

    alias_method :request_without_superhttpcache, :request
    alias_method :request, :request_with_superhttpcache

  end
end