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

end