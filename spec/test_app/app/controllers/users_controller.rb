require 'net/http'
class UsersController < ApplicationController

  def index
    @names = User.all.map { |user| user.name }
    render nothing: true
  end

  def http_request
    url = URI.parse('http://printatestpage.com/')
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    render nothing: true
  end
end