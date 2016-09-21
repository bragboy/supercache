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

end