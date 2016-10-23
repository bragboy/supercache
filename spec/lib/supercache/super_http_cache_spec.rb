require 'spec_helper'

describe Net::HTTP do
  it 'should overwrite request with request_with_superhttpcache' do
    expect(Net::HTTP.instance_method(:request)).to eq Net::HTTP.instance_method(:request_with_superhttpcache)
  end
end
