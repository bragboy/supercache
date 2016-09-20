class User < ActiveRecord::Base
  has_one :book
  has_one :publication
end
