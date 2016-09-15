require 'spec_helper'

describe SuperQueryCache do
  it 'should include SuperQueryCache in  ActiveRecord::ConnectionAdapters::AbstractAdapter ancestors' do
   expect(ActiveRecord::ConnectionAdapters::AbstractAdapter.ancestors).to include SuperQueryCache
  end
end
