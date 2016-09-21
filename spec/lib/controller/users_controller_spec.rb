require 'spec_helper'
require 'rails_helper'

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
    it 'should cache http response', solr: true do
      User.create(name: "ethiraj")
      Rails.cache.write(:http_supercache, true)
      expect(Rails.cache.read("7f63f457060254041691e0632ee192a12dd835a4")).to eq nil
      result = User.search { fulltext "ethiraj" }
      expect(result.hits.count).to eq 1
      expect(Rails.cache.read("7f63f457060254041691e0632ee192a12dd835a4")).not_to eq nil
    end
  end

end