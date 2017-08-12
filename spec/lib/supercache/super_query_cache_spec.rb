require 'spec_helper'

describe ActiveRecord::ConnectionAdapters::QueryCache do
  it 'should overwrite cache_sql with cache_sql_with_superquerycache' do
   expect(subject.instance_method(:cache_sql)).to eq ActiveRecord::ConnectionAdapters::QueryCache.instance_method(:cache_sql_with_superquerycache)
  end
end
