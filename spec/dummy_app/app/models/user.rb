class User < ActiveRecord::Base
	searchable do
    text :name,:email
  end

  after_create { |user| user.index! }
end
