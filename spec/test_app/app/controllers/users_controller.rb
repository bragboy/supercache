class UsersController < ApplicationController

  def index
    @names = User.all.map { |user| user.name }
  end
end