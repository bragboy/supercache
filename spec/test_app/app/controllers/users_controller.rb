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

  def add_to_sql_exception
    sql_exp = Rails.cache.read(:sql_exp)
    sql_exp[params[:sql]] = params[:status] == "false"
    Rails.cache.write(:sql_exp,sql_exp)
    render nothing: true
  end

  def add_to_http_exception
    http_exp = Rails.cache.read(:http_exp)
    http_exp[params[:url]] = params[:status] == "false"
    Rails.cache.write(:http_exp,http_exp)
    render nothing: true
  end
end