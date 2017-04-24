require 'spec_helper'

describe SuperHttpCache do
  it 'should include SuperQueryCache in  ActiveRecord::ConnectionAdapters::AbstractAdapter ancestors' do
    expect(Net::HTTP.ancestors).to include subject
  end
end