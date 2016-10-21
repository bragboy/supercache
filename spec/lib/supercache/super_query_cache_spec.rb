require 'spec_helper'

if RUBY_VERSION < "2.0"
  describe ActiveRecord::ConnectionAdapters::QueryCache do
    it 'should overwrite cache_sql with cache_sql_with_superquerycache' do
     expect(subject.instance_method(:cache_sql)).to eq ActiveRecord::ConnectionAdapters::QueryCache.instance_method(:cache_sql_with_superquerycache)
    end
  end
else
  describe SuperQueryCache do
    it 'should include SuperQueryCache in  ActiveRecord::ConnectionAdapters::AbstractAdapter ancestors' do
     expect(ActiveRecord::ConnectionAdapters::AbstractAdapter.ancestors).to include subject
    end
  end
end
