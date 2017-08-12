require 'spec_helper'

describe UsersController,type: :controller do
  context "superquerycache" do
    before do
      Rails.cache.clear
      User.create(name: "ethiraj")
      ActiveRecord::Base.connection.enable_query_cache!
    end
    it 'should cache active record query' do
      #Cache number calculated for select * from users
      Rails.cache.write(:ar_supercache, true)
      expect(Rails.cache.read("74dd740d4eb812c6e9ace627bdd4ed97eb85cbec")).to eq nil
      get :index
      expect(Rails.cache.read("74dd740d4eb812c6e9ace627bdd4ed97eb85cbec")).not_to eq nil
    end
  end

  context "superhttpcache" do
    before do
      Rails.cache.clear
    end
    it 'should cache http request' do
      Rails.cache.write(:http_supercache, true)
      expect(Rails.cache.read("a7ba33136cf723c9ac70c38e911012533f230b91")).to eq nil
      get :http_request
      expect(Rails.cache.read("a7ba33136cf723c9ac70c38e911012533f230b91")).not_to eq nil
    end
  end

  context "superhttpcache" do
    before do
      Rails.cache.clear
      Rails.cache.write(:sql_exp, {})
    end
    it 'should add exception to the sql' do
      get :add_to_sql_exception, sql: "Select * from users", status: "false"
      expect(Rails.cache.read(:sql_exp)["Select * from users"]).to eq true
    end
  end

  context "superhttpcache" do
    before do
      Rails.cache.clear
      Rails.cache.write(:http_exp, {})
    end
    it 'should add exception to http request' do
      get :add_to_http_exception, url: "ethigeek.com", status: "false"
      expect(Rails.cache.read(:http_exp)["ethigeek.com"]).to eq true
    end
  end

end